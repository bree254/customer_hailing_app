import 'package:customer_hailing/core/app_export.dart';
import 'package:get/get.dart';

class PromoController extends GetxController {
  var promoCode = ''.obs;
  var isActivated = false.obs;
  var activePromos = <String>[].obs;
  var errorMessage = ''.obs;

  final PrefUtils _prefUtils = PrefUtils();

  @override
  void onInit() {
    super.onInit();
    loadPromos();
  }

  void activatePromo(String enteredCode) {
    if (enteredCode == 'MD30X56') {
      activePromos.add(enteredCode);
      _prefUtils.setStringList('activePromos', activePromos); // Save active promos
      promoCode.value = enteredCode;
      isActivated.value = true;
      errorMessage.value = '';  // Clear the error message on successful activation
    } else {
      errorMessage.value = 'Invalid Promo Code';
      isActivated.value = false;
    }
  }

  void loadPromos() {
    List<String>? savedPromos = _prefUtils.getStringList('activePromos');
    if (savedPromos != null && savedPromos.isNotEmpty) {
      activePromos.assignAll(savedPromos);
      isActivated.value = true;
      promoCode.value = activePromos.last;
    }
  }
}