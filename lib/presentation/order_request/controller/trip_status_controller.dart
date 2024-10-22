import 'package:get/get.dart';
import 'dart:async';

import '../screens/trip_summary_screen.dart';

enum TripStatus { onTheWay, arrived, headingToDestination }

class TripStatusController extends GetxController {
 var tripStatus = TripStatus.onTheWay.obs;

 TripStatusController() {
  // Simulate background process to update trip status periodically
  Timer.periodic(const Duration(seconds: 10), (timer) {
   switch (tripStatus.value) {
    case TripStatus.onTheWay:
     updateTripStatus(TripStatus.arrived);
     break;
    case TripStatus.arrived:
     updateTripStatus(TripStatus.headingToDestination);
     break;
    case TripStatus.headingToDestination:
     timer.cancel();
     Get.to(() => TripSummaryScreen());// Stop the timer after reaching the destination
     break;
   }
  });
 }

 void updateTripStatus(TripStatus status) {
  tripStatus.value = status;
 }
}
