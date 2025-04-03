import 'dart:async';
import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/data/models/api_response.dart';
import 'package:customer_hailing/data/models/ride_requests/confirm_trip_response.dart';
import 'package:customer_hailing/data/models/ride_requests/driver_locations_response.dart';
import 'package:customer_hailing/data/models/ride_requests/frequent_destinations_response.dart';
import 'package:customer_hailing/data/models/ride_requests/locations_update_response.dart';
import 'package:customer_hailing/data/models/ride_requests/rate_trip_response.dart';
import 'package:customer_hailing/data/models/ride_requests/save_destination_response.dart';
import 'package:customer_hailing/data/models/ride_requests/schedule_trip_response.dart';
import 'package:customer_hailing/data/models/ride_requests/scheduled_trips_response.dart';
import 'package:customer_hailing/data/models/ride_requests/search_locations_response.dart';
import 'package:customer_hailing/data/models/ride_requests/share_trip_response.dart';
import 'package:customer_hailing/data/models/ride_requests/trip_details_response.dart';
import 'package:customer_hailing/data/models/ride_requests/trip_history_response.dart';
import 'package:customer_hailing/presentation/order_request/controller/map_controller.dart';
import 'package:customer_hailing/presentation/order_request/screens/search_location_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../../data/api/endpoints.dart';
import '../../../data/models/ride_requests/scheduled_trip_details_response.dart';
import '../../../data/models/ride_requests/trip_history_details_response.dart';
import '../../../data/repos/ride_service_repository.dart';
import '../../../routes/routes.dart';
import '../../auth/controller/auth_controller.dart';

class RideServiceController extends GetxController {
  final RideServiceRepository rideServiceRepository;

  RideServiceController({required this.rideServiceRepository});

  final TextEditingController destinationController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  String? accessToken;

  RxList<FareAmount> fareAmounts = <FareAmount>[].obs;
  RxList<AvailableRide> availableRides = <AvailableRide>[].obs;

 // late final Rx<Data> data = Data().obs;

  RxList<DriverLocationsResponse> drivers = <DriverLocationsResponse>[].obs;

  var tripDetails = TripDetailsResponse().obs;
  var history = TripHistoryResponse().obs;
  Rx<TripHistoryDetailsResponse> historyDetails = TripHistoryDetailsResponse().obs;

  RxList<ScheduledTripsResponse> scheduledTrips = <ScheduledTripsResponse>[].obs;
  var scheduledTripDetails = ScheduledTripDetailsResponse().obs;

  var frequentDestinations = FrequentDestinationsResponse().obs;

  var locationUpdates = LocationsUpdatesResponse().obs;
  @override
  void onInit() async {
    super.onInit();
    accessToken = await PrefUtils().retrieveToken('access_token');
    //getDriverLocations();

    String? requestId = await PrefUtils().retrieveRequestId();
    print('Retrieved requestId: $requestId');

    if (requestId != null) {
      await getTripDetails(requestId);
    } else {
      print('RequestId is null. Cannot fetch trip details.');
    }

    String? customerId = await PrefUtils().getUserData()!.id;
    print('Retrieved customerId: $customerId');
    if (customerId != null) {
      await getTripHistory(customerId);
      await getScheduledTrips(customerId);
      await getFrequentDestinations(customerId);
    } else {
      print('customerId is null. Cannot fetch trip history.');
    }

    if (scheduledTrips.isNotEmpty) {
      String tripId = scheduledTrips.first.id!;
      await getScheduledTripDetails(tripId);
     // await getLocationUpdates(tripId);
    } else {
      print('No scheduled trips available.');
    }

  }

  ///with location controller
  Future<void> uploadCustomerLocation() async {
    await _uploadCustomerLocation(destinationController.text,locationController.text);
  }

  // Future<void> uploadCustomerLocationWithDestination(String destination) async {
  //   await _uploadCustomerLocation(destination,locationController.text);
  // }

  Future<void> uploadCustomerLocationWithDestination(String destination,String location) async {
    await _uploadCustomerLocation(destination,location);
  }

  Future<void> _uploadCustomerLocation(String destination,String location) async {
    try {
      final mapController = Get.find<MapController>();

      // Get the coordinates for the destination address
      LatLng? destinationCoordinates = await mapController.getCoordinatesFromAddress(destination);
      LatLng? locationCoordinates = await mapController.getCoordinatesFromAddress(location);

      if (destinationCoordinates == null || locationCoordinates == null) {
        //Get.snackbar('Error', 'Failed to get coordinates for the destination address.');
        return;
      }

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
      Map<String, dynamic> requestData = {
        'originLatitude': locationCoordinates.latitude,
        'originLongitude': locationCoordinates.longitude,
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
     // Get.snackbar('Error', 'Failed to upload customer location');
    }
  }

  Future<String?> confirmTrip(String dropOffAddress,String pickUpAddress, String rideCategory, String paymentMethod, double fareEstimate) async {
    try {
      final mapController = Get.find<MapController>();
      final authController = Get.find<AuthController>();

      // Get the coordinates for the destination address
      LatLng? destinationCoordinates = await mapController.getCoordinatesFromAddress(dropOffAddress);
      LatLng? locationCoordinates = await mapController.getCoordinatesFromAddress(pickUpAddress);

      if (destinationCoordinates == null && locationCoordinates == null) {
        Get.snackbar('Error', 'Failed to get coordinates for the destination address.');
        return null;
      }

      // // Convert current location to address
      // String pickupAddress = await mapController.convertToAddress(
      //   mapController.currentPosition.value!.latitude,
      //   mapController.currentPosition.value!.longitude,
      // );

      // Ensure organizationId is a single string
      String? organizationId = authController.user.value.orgId?.isNotEmpty == true ? authController.user.value.orgId!.first : null;
      String? deptId = authController.user.value.departmentId?.isNotEmpty == true ? authController.user.value.departmentId!.first : null;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      Map<String, dynamic> requestData = {

        'customerId': authController.user.value.id,
        'departmentId': deptId,
        "organizationId": organizationId,
        'pickupLatitude': locationCoordinates!.latitude,
        'pickupLongitude': locationCoordinates.longitude,
        // 'pickupLatitude': mapController.currentPosition.value!.latitude,
        // 'pickupLongitude': mapController.currentPosition.value!.longitude,
        'destinationLatitude': destinationCoordinates!.latitude,
        'destinationLongitude': destinationCoordinates.longitude,
        'pickupAddress': pickUpAddress,
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
        print( 'trip confirmed: ${response.data}');
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
      // Iterate over the trip history and fetch details for each trip
      for (var trip in response.data!) {
        await getTripHistoryDetails(trip.id!);
      }
    } catch (e) {
      // Handle any errors
      print('Error fetching Trip history: $e');
    }
  }

  Future<void> getTripHistoryDetails(String tripId) async {
    try {
      //final authController = Get.find<AuthController>();

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      //final driverId = authController.driver.value.id.toString();

      // Log the request URL and parameters
      print('Trip history details  with tripId: $tripId');
      print('Trip history details Request URL: ${Endpoints.historyDetails}$tripId/completedTripDetails');
      print('Trip history details Headers: $headers');

      TripHistoryDetailsResponse response = await rideServiceRepository.tripHistoryDetails(
        headers: headers,
        tripId: tripId,
      );

// Ensure the history variable is of type TripHistoryDetailsResponse
      historyDetails.value = response;
      print('Trip history details fetched successfully: ${response.toJson()}');
    } catch (e) {
      // Handle any errors
      print('Error fetching Trip history details: $e');
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

  Future<void> scheduleTrip(String pickupAddress, String dropOffAddress, String rideCategory, double estimatedFare,String paymentMethod, String date, String time) async {
    try {
      final mapController = Get.find<MapController>();
      final authController = Get.find<AuthController>();

      // Get the coordinates for the destination address
      LatLng? destinationCoordinates = await mapController.getCoordinatesFromAddress(dropOffAddress);
      LatLng? locationCoordinates = await mapController.getCoordinatesFromAddress(pickupAddress);

      if (destinationCoordinates == null && locationCoordinates == null) {
        Get.snackbar('Error', 'Failed to get coordinates for the destination address.');
        return;
      }

      // // Convert current location to address
      // String pickupAddress = await mapController.convertToAddress(
      //   mapController.currentPosition.value!.latitude,
      //   mapController.currentPosition.value!.longitude,
      // );

      // Ensure organizationId is a single string
      String? organizationId = authController.user.value.orgId?.isNotEmpty == true ? authController.user.value.orgId!.first : null;

      // Format date and time
      final formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
      final formattedTime = DateFormat('hh:mm a').format(DateFormat('HH:mm').parse(time));

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      Map<String, dynamic> requestData = {
        'customerId': authController.user.value.id,
        'organizationId': organizationId,
        'pickupLatitude': locationCoordinates!.latitude,
        'pickupLongitude': locationCoordinates.longitude,
        'destinationLatitude': destinationCoordinates!.latitude,
        'destinationLongitude': destinationCoordinates.longitude,
        'pickupAddress': pickupAddress,
        'dropOffAddress': dropOffAddress,
        'rideCategory': rideCategory,
        'isImmediate': false,
        'estimatedFare': estimatedFare,
        'requestType': 'AIRPORT',
        'paymentMethod': paymentMethod,
        'pickupTime': formattedTime,
        'pickupDate': formattedDate,
      };

      print('schedule trip request data: $requestData');
      print('schedule trip headers: $headers');

      ScheduleTripResponse response = await rideServiceRepository.scheduleTrip(
        headers: headers,
        requestData: requestData,
      );

      if (response.status == "201" || response.message == 'Trip Scheduled Successfully' || response.status == "200") {
        print('Trip Scheduled message: ${response.message}');
        Get.offNamed(AppRoutes.scheduleTrip);
      } else {
        print('Failed to schedule trip: ${response.message}');
      }
    } catch (e) {
      print('schedule Trip Error: ${e.toString()}');
    }
  }

  Future<void> getScheduledTrips(String customerId) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      // Log the request URL and parameters
      print('Scheduled trips with customerId: $customerId');
      print('Scheduled trips Request URL: ${Endpoints.scheduledTrip}?customerId=$customerId');
      print('Scheduled trips Headers: $headers');


      List<ScheduledTripsResponse> response = await rideServiceRepository.scheduledTrips(
        headers: headers, customerId: customerId,
      );

      scheduledTrips.value = response;
      print('Scheduled trips fetched successfully: ${response.map((trip) => trip.toJson()).toList()}');

    } catch (e) {
      // Handle any errors
      print('Error fetching scheduled trips: $e');
    }
  }


  Future<void> getScheduledTripDetails(String tripId) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      // Log the request URL and parameters
      print('Scheduled trips details with tripId: $tripId');
      print('Scheduled trips details Request URL: ${Endpoints.scheduledTrip}$tripId');
      print('Scheduled trips details  Headers: $headers');

      ScheduledTripDetailsResponse response = await rideServiceRepository.scheduledTripDetails(
        headers: headers,
        tripId: tripId,
      );

      scheduledTripDetails.value = response;
      print('Scheduled trip details fetched successfully: ${response.toJson()}');
    } catch (e) {
      print('Error fetching scheduled trip details: $e');
    }
  }

  Future<String?> shareTrip() async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final tripId = tripDetails.value.tripId.toString();

    print('Share Trip ID: $tripId');
    print('Share Trip Headers: $headers');
    print('Share Trip Request URL: ${Endpoints.shareTrip}');

    try {
      final ShareTripResponse response = await rideServiceRepository.shareTrip(
        headers: headers,
        tripId: tripId,
      );

      if (response.status == "200") {
        debugPrint('Trip link generated successfully');
        print('share trip response: ${response.toJson()}');
        return response.data?.shareableLink;
      } else {
        debugPrint('Failed to generate trip link');
        return null;
      }
    } catch (e) {
      debugPrint('Error generating trip link: $e');
      return null;
    }
  }

  Future<void> raiseSos() async {
    try {
      final mapController = Get.find<MapController>();
      final authController = Get.find<AuthController>();

      // Format date and time to "dd-MM-yyyy HH:mm"
      final formattedDateTime = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      Map<String, dynamic> requestData = {
        'tripId': tripDetails.value.tripId,
        'customerId': authController.user.value.id,
        'driverId': tripDetails.value.driver!.id,
        'startTime': formattedDateTime,
        'latitude': mapController.currentPosition.value!.latitude,
        'longitude': mapController.currentPosition.value!.longitude,
        'sosType': 'LOCAL_AUTHORITIES',
      };

      print('raise sos request data: $requestData');
      print('raise sos headers: $headers');

      ApiResponse response = await rideServiceRepository.raiseSos(
        headers: headers,
        requestData: requestData,
      );

      if (response.status == "201") {
        print('SOS request logged successfully: ${response.message}');
      } else {
        print('Failed to raise sos trip: ${response.message}');
      }
    } catch (e) {
      print('raise sos Error: ${e.toString()}');
    }
  }

  Future<void> canceltrip() async {
    try {
      final authController = Get.find<AuthController>();

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      Map<String, dynamic> requestData = {

        'customerId':  authController.user.value.id,
        'reason': '' ,
        'reassignTrip': false,
      };

      print('cancel trip request data: $requestData');
      print('cancel trip headers: $headers');


    final tripId = tripDetails.value.tripId.toString();
    print('cancel trip tripId: $tripId');

      ApiResponse response = await rideServiceRepository.cancelTrip(
        headers: headers,
        requestData: requestData, tripId: tripId,
      );


      if ( response.status == "200") {
        print( 'trip cancelled : ${response.message}');
        Get.toNamed(AppRoutes.home);

      }
    } catch (e) {
      print(' cancel Trip Error: ${ e.toString()}',);
      return null;
    }
  }

  Future<void> cancelOnTrip(String reason) async {
    try {
      final authController = Get.find<AuthController>();

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      Map<String, dynamic> requestData = {

        'customerId':  authController.user.value.id,
        'reason': reason ,
        'reassignTrip': false,
      };

      print('cancel trip request data: $requestData');
      print('cancel trip headers: $headers');


      final tripId = tripDetails.value.tripId.toString();
      print('cancel trip tripId: $tripId');

      ApiResponse response = await rideServiceRepository.cancelTrip(
        headers: headers,
        requestData: requestData, tripId: tripId,
      );


      if ( response.status == "200") {
        print( 'trip cancelled : ${response.message}');
        Get.toNamed(AppRoutes.home);

      }
    } catch (e) {
      print(' cancel Trip Error: ${ e.toString()}',);
      return null;
    }
  }

  Future<void> saveDestination(String destination ,String name) async {
    try {
      final mapController = Get.find<MapController>();
      final authController = Get.find<AuthController>();

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
        'name': name,
        'latitude': destinationCoordinates.latitude,
        'longitude': destinationCoordinates.longitude,
      };
      String? customerId = authController.user.value.id?.isNotEmpty == true ? authController.user.value.id! : null;

      print('save destination request data: $requestData');
      print('save destination trip headers: $headers');
      print('save destinationRequest URL: ${Endpoints.saveDestination}?userId=$customerId');


      SaveDestinationResponse response = await rideServiceRepository.saveDestination(
        headers: headers,
        requestData: requestData,
        customerId: customerId!,
      );

      if (response != null) {
        print('Destination  saved  message}');
        Get.offNamed(AppRoutes.savedLocation);
      } else {
        print('Failed to save destination }');
      }
    } catch (e) {
      print('schedule Trip Error: ${e.toString()}');
    }
  }

  Future<void> getFrequentDestinations(String customerId) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      // Log the request URL and parameters
      print('Frequent destinations with customerId: $customerId');
      print('Frequent destinations Request URL: ${Endpoints.tripHistory}?userId=$customerId');
      print('Frequent destinations Headers: $headers');

      FrequentDestinationsResponse response = await rideServiceRepository.getFrequentDestinations(
        headers: headers, customerId: customerId,

      );
      frequentDestinations.value = response;
      print('Frequent destinations fetched successfully: ${response.toJson()}');

    } catch (e) {
      // Handle any errors
      print('Error fetching Frequent destinations: $e');
    }
  }

  Future<void> getLocationUpdates(String tripId) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      // Log the request URL and parameters
      print('Scheduled trips details with tripId: $tripId');
      print('Scheduled trips details Request URL: ${Endpoints.locationUpdates}$tripId');
      print('Scheduled trips details  Headers: $headers');

      LocationsUpdatesResponse response = await rideServiceRepository.locationUpdates(
        headers: headers,
        tripId: tripId,
      );

      locationUpdates.value = response;
      print('location updates fetched successfully: ${response.toJson()}');
    } catch (e) {
      print('Error fetching location updates : $e');
    }
  }
  @override
  void onClose() {
    // Cancel the timer when the controller is closed
    _timer?.cancel();
    super.onClose();
  }
}
