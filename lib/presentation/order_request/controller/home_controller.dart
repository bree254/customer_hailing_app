import 'package:customer_hailing/core/app_export.dart';

class HomeController extends GetxController {
  var pastDestinations = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadPastDestinations();
  }

  Future<void> _loadPastDestinations() async {
    await PrefUtils().init();
    pastDestinations.value = PrefUtils().getPastDestinations();
  }
}
