import 'dart:async';
import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/data/models/ride_requests/confirm_trip_response.dart';
import 'package:customer_hailing/data/models/ride_requests/driver_locations_response.dart';
import 'package:customer_hailing/data/models/ride_requests/rate_trip_response.dart';
import 'package:customer_hailing/data/models/ride_requests/search_locations_response.dart';
import 'package:customer_hailing/data/models/ride_requests/trip_details_response.dart';
import 'package:customer_hailing/data/models/ride_requests/trip_history_response.dart';
import 'package:customer_hailing/presentation/order_request/controller/map_controller.dart';
import 'package:customer_hailing/presentation/order_request/screens/search_location_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../data/api/endpoints.dart';
import '../../../data/repos/ride_service_repository.dart';
import '../../../routes/routes.dart';
import '../../auth/controller/auth_controller.dart';

class RideServiceController extends GetxController {
  final RideServiceRepository rideServiceRepository;

  RideServiceController({required this.rideServiceRepository});


  String? accessToken;

  final TextEditingController destinationController = TextEditingController();
  RxList<FareAmount> fareAmounts = <FareAmount>[].obs;
  RxList<AvailableRide> availableRides = <AvailableRide>[].obs;
  //Rx<Data> data = Data().obs;

  late final Rx<Data> data = Data().obs;

  RxList<DriverLocationsResponse> drivers = <DriverLocationsResponse>[].obs;
  var tripDetails = TripDetailsResponse().obs;
  var history = TripHistoryResponse().obs;

  @override
  void onInit() async {
    super.onInit();
    accessToken = await PrefUtils().retrieveToken('access_token');
    //getDriverLocations();

    // Retrieve the requestId from shared preferences
    String? requestId = await PrefUtils().retrieveRequestId();

    // Print the retrieved requestId for debugging
    print('Retrieved requestId: $requestId');

    if (requestId != null) {
      // Fetch trip details using the requestId
      await getTripDetails(requestId);
    } else {
      print('RequestId is null. Cannot fetch trip details.');
    }

    String? customerId = await PrefUtils().getUserData()!.id;
    print('Retrieved customerId: $requestId');
    if (customerId != null) {
      await getTripHistory(customerId);
    } else {
      print('customerId is null. Cannot fetch trip history.');
    }
  }

  Future<void> uploadCustomerLocation() async {
    await _uploadCustomerLocation(destinationController.text);
  }

  Future<void> uploadCustomerLocationWithDestination(String destination) async {
    await _uploadCustomerLocation(destination);
  }

  Future<void> _uploadCustomerLocation(String destination) async {
    try {
      final mapController = Get.find<MapController>();

      // Get the coordinates for the destination address
      LatLng? destinationCoordinates = await mapController.getCoordinatesFromAddress(destination);

      if (destinationCoordinates == null) {
        //Get.snackbar('Error', 'Failed to get coordinates for the destination address.');
        return;
      }

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
      Map<String, dynamic> requestData = {
        'originLatitude': mapController.currentPosition.value!.latitude,
        'originLongitude': mapController.currentPosition.value!.longitude,
        'destinationLatitude': destinationCoordinates.latitude,
        'destinationLongitude': destinationCoordinates.longitude,
        'searchRadius': 5000,
        "rideCategory": "",
      };

      print('post customer location : $requestData');
      print('post customer location : $headers');

      SearchLocationsResponse response = await rideServiceRepository.uploadCustomerLocation(
        headers: headers,
        requestData: requestData,
      );

      print(response.toJson());
      if (response.message == 'Rides Fetched Successfully') {
        fareAmounts.value = response.fareAmounts ?? [];
        availableRides.value = response.availableRides?.whereType<AvailableRide>().toList() ?? [];

        print(response.message);

              // Print available rides
              print('Available Rides:');
              for (var ride in availableRides) {
                print('Driver ID: ${ride.driverId}, Latitude: ${ride.latitude}, Longitude: ${ride.longitude}, Ride Category: ${ride.rideCategory}');
              }

              // Print fare amounts
              print('Fare Amounts:');
              for (var fare in fareAmounts) {
                print('Ride Category: ${fare.rideCategoryName}, Fare: ${fare.fare}, Trip Duration: ${fare.tripDuration}, Distance to Drop Off: ${fare.distanceToDropOff}');
              }
      }

    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }


  Future<String?> confirmTrip(String dropOffAddress, String rideCategory, String paymentMethod, double fareEstimate) async {
    try {
      final mapController = Get.find<MapController>();
      final authController = Get.find<AuthController>();

      // Get the coordinates for the destination address
      LatLng? destinationCoordinates = await mapController.getCoordinatesFromAddress(dropOffAddress);

      if (destinationCoordinates == null) {
        Get.snackbar('Error', 'Failed to get coordinates for the destination address.');
        return null;
      }

      // Convert current location to address
      String pickupAddress = await mapController.convertToAddress(
        mapController.currentPosition.value!.latitude,
        mapController.currentPosition.value!.longitude,
      );

      // Ensure organizationId is a single string
      String? organizationId = authController.user.value.orgId?.isNotEmpty == true ? authController.user.value.orgId!.first : null;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      Map<String, dynamic> requestData = {

        'customerId': authController.user.value.id,
        'organizationId': organizationId,
        'pickupLatitude': mapController.currentPosition.value!.latitude,
        'pickupLongitude': mapController.currentPosition.value!.longitude,
        'destinationLatitude': destinationCoordinates.latitude,
        'destinationLongitude': destinationCoordinates.longitude,
        'pickupAddress': pickupAddress,
        'dropOffAddress': dropOffAddress,
        'rideCategory': rideCategory,
        "fareEstimate": fareEstimate,
        'paymentMethod': paymentMethod,
        'isImmediate': true,
      };

      print('Confirm trip request data: $requestData');
      print('Confirm trip headers: $headers');

      ConfirmTripResponse response = await rideServiceRepository.confirmTrip(
        headers: headers,
        requestData: requestData,
      );


      if ( response.data != null) {
        // Save the requestId to shared preferences
        await PrefUtils().saveRequestId(response.data!.requestId!);

        // Start polling for trip details
        startPollingTripDetails(response.data!.requestId!);

        // Navigate to the AwaitDriver screen
        Get.toNamed(AppRoutes.awaitDriver);

        return response.data!.requestId; // Return the requestId


      } else {
        print( 'Failed to confirm trip: ${response.message}');
        return null;
      }
    } catch (e) {
      print(' Confirm Trip Error: ${ e.toString()}',);
      return null;
    }
  }


  void checkTripStatus() {
    final status = tripDetails.value.tripStatus;

    if (status == 'ACCEPTED') {
      Get.toNamed(AppRoutes.tripStatus);
    }
  }

  Future<void> getTripDetails(String requestId) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      // Log the request URL and parameters
      print('Trip details with requestId: $requestId');
      print('Trip details Request URL: ${Endpoints.tripDetails}$requestId');
      print('Trip details Headers: $headers');

      TripDetailsResponse response = await rideServiceRepository.getTripDetails(
        headers: headers,
        requestId: requestId,
      );

      tripDetails.value = response;

      checkTripStatus();
      // Handle the user response as needed
      print('Trip details fetched successfully: ${response.toJson()}');
    } catch (e) {
      // Handle any errors
      print('Error fetching trip details: $e');
    }
  }

  Timer? _timer;

  void startPollingTripDetails(String requestId) {
    // Cancel any existing timer
    _timer?.cancel();

    // Start a new timer to fetch trip details every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      await getTripDetails(requestId);
    });
  }

  Future<void> getTripHistory(String customerId) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      // Log the request URL and parameters
      print('Trip history with customerId: $customerId');
      print('Trip history Request URL: ${Endpoints.tripHistory}$customerId/completedTrips');
      print('Trip history Headers: $headers');

      TripHistoryResponse response = await rideServiceRepository.tripHistory(
        headers: headers, customerId: customerId,

      );
      history.value = response;
      print('Trip history fetched successfully: ${response.toJson()}');
    } catch (e) {
      // Handle any errors
      print('Error fetching Trip history: $e');
    }
  }

  Future<void> rateTrip(double rating) async {
    try {

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      Map<String, dynamic> requestData = {

        'tripId': tripDetails.value.tripId,
        'rating': rating ,
        'feedback': "great trip",
        'isCustomerRating': true,
      };

      print('rate trip request data: $requestData');
      print('rate trip headers: $headers');

      RateTripResponse response = await rideServiceRepository.rateTrip(
        headers: headers,
        requestData: requestData,
      );


      if ( response.status == "200") {
        print( 'trip rated : ${response.message}');
        Get.toNamed(AppRoutes.home);

      }
    } catch (e) {
      print(' rate Trip Error: ${ e.toString()}',);
      return null;
    }
  }
  @override
  void onClose() {
    // Cancel the timer when the controller is closed
    _timer?.cancel();
    super.onClose();
  }
}
