import 'package:customer_hailing/routes/routes.dart';
import 'package:get/get.dart';

enum RideStatus {
  searching,
  connecting,
  lookingForAnother,
}

class RideStatusController extends GetxController {
  var currentStatus = RideStatus.searching.obs;

  void updateStatus(RideStatus status) {
    currentStatus.value = status;

    if (status == RideStatus.connecting) {
      Future.delayed(const Duration(seconds: 3), () {
        bool driverFound = _checkForDriver();

        if (driverFound) {
          Get.toNamed(AppRoutes.tripStatus); // Navigate to the ride confirmed screen
        } else {
          updateStatus(RideStatus.lookingForAnother);
        }
      });
    }
  }
  bool _checkForDriver() {
    // Simulate driver check. Replace with actual logic.
    return true;
  }

  // bool _checkForDriver() {
  //   // Simulate driver check. Replace with actual logic.
  //   return DateTime.now().second % 2 == 0;
  //   // Randomly returns true or false based on the current second
  //
  //   // return true; // or false based on actual condition
  // }



  void searchForDriver() {
    // Update status to searching
    updateStatus(RideStatus.searching);

    // Simulate searching for driver
    Future.delayed(const Duration(seconds: 3), () {
      updateStatus(RideStatus.connecting);

    });
  }

  void cancelRequest() {
    // Handle the cancellation of the request
    // For example, reset to initial status or navigate back to a previous screen
    updateStatus(RideStatus.searching);
  }
}
