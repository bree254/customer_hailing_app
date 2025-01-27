import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/data/models/ride_requests/search_locations_response.dart';
import 'package:customer_hailing/presentation/order_request/controller/map_controller.dart';
import 'package:customer_hailing/presentation/order_request/screens/search_location_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../data/repos/ride_service_repository.dart';

class RideServiceController extends GetxController {
  final RideServiceRepository rideServiceRepository;

  RideServiceController({required this.rideServiceRepository});

  String? accessToken;

  final TextEditingController destinationController = TextEditingController();
  RxList<FareAmount> fareAmounts = <FareAmount>[].obs;
  RxList<AvailableRide> availableRides = <AvailableRide>[].obs;

  @override
  void onInit() async {
    super.onInit();
    accessToken = await PrefUtils().retrieveToken('access_token');
  }

  // Future<void> uploadCustomerLocation() async {
  //   try {
  //     final mapController = Get.find<MapController>();
  //
  //     // Get the coordinates for the destination address
  //     LatLng? destinationCoordinates = await mapController.getCoordinatesFromAddress(destinationController.text);
  //
  //     if (destinationCoordinates == null) {
  //       //Get.snackbar('Error', 'Failed to get coordinates for the destination address.');
  //       return;
  //     }
  //
  //     Map<String, String> headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $accessToken',
  //     };
  //     Map<String, dynamic> requestData = {
  //       'originLatitude': mapController.currentPosition.value!.latitude,
  //       'originLongitude': mapController.currentPosition.value!.longitude,
  //       'destinationLatitude': destinationCoordinates.latitude,
  //       'destinationLongitude': destinationCoordinates.longitude,
  //       'searchRadius': 5000,
  //     };
  //     print('post customer location : $requestData');
  //     print('post customer location : $headers');
  //
  //     SearchLocationsResponse response = await rideServiceRepository.uploadCustomerLocation(
  //       headers: headers,
  //       requestData: requestData,
  //     );
  //     print(response.toJson());
  //     if (response.message == 'Rides Fetched Successfully') {
  //       // fareAmounts.value = response.fareAmounts!;
  //
  //       fareAmounts.value = response.fareAmounts ?? [];
  //       availableRides.value = response.availableRides?.whereType<AvailableRide>().toList() ?? [];
  //       print(response.message);
  //
  //       // Print available rides
  //       print('Available Rides:');
  //       for (var ride in availableRides) {
  //         print('Driver ID: ${ride.driverId}, Latitude: ${ride.latitude}, Longitude: ${ride.longitude}, Ride Category: ${ride.rideCategory}');
  //       }
  //
  //       // Print fare amounts
  //       print('Fare Amounts:');
  //       for (var fare in fareAmounts) {
  //         print('Ride Category: ${fare.rideCategoryName}, Fare: ${fare.fare}, Trip Duration: ${fare.tripDuration}, Distance to Drop Off: ${fare.distanceToDropOff}');
  //       }
  //     }
  //
  //   } catch (e) {
  //     // Handle any errors
  //     Get.snackbar('Error', e.toString());
  //   } finally {
  //     // EasyLoading.dismiss();
  //   }
  // }

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
}
