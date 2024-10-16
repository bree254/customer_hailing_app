import 'package:get/get.dart';

class CallController extends GetxController {
  var callStatus = 'Incoming'.obs;
  var callerName = 'James Smith'.obs;
  var callerImageUrl = 'assets/images/driver.png'.obs;
  var callDuration = '01:58'.obs;

  void acceptCall() {
    callStatus.value = 'Ongoing';
  }

  void endCall() {
    callStatus.value = 'Ended';
    Get.back();
  }

  void rejectCall() {
    callStatus.value = 'Rejected';
    Get.back();
  }
}