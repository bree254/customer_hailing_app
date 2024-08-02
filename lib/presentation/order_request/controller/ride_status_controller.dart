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
  }

  void searchForDriver() {
    // Update status to searching
    updateStatus(RideStatus.searching);

    // Simulate searching for driver
    Future.delayed(const Duration(seconds: 3), () {
      updateStatus(RideStatus.connecting);

      // Simulate connecting to driver
      Future.delayed(const Duration(seconds: 5), () {
        // If failed to connect, look for another driver
        updateStatus(RideStatus.lookingForAnother);
      });
    });
  }

  void cancelRequest() {
    // Handle the cancellation of the request
    // For example, reset to initial status or navigate back to a previous screen
    updateStatus(RideStatus.searching);
  }
}
