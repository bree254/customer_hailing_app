import 'package:get/get.dart';

class PromoController extends GetxController {
  var promoCode = ''.obs;
  var isActivated = false.obs;
  var errorMessage = ''.obs;

  // Mock function to simulate promo validation
  void activatePromo() {
    if (promoCode.value == 'MD30X56') {  // Replace with actual validation logic
      isActivated.value = true;          // Activate promotion if valid
      errorMessage.value = '';           // Clear error message
    } else {
      errorMessage.value = 'Invalid Promo Code';  // Show error message
    }
  }
}