import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
import '../../../routes/routes.dart';
class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String? cardNumber;
  String? expiryDate;
  String? cvv;

  @override
  void initState() {
    super.initState();

    // Retrieve arguments passed from AddCardScreen
    // final args = Get.arguments;
    // cardNumber = args['card'] ?? '';
    // expiryDate = args['expiry_date'] ?? '';
    // cvv = args['cvv'] ?? '';
  }
  @override
  Widget build(BuildContext context) {
    // Retrieve arguments passed from AddCardScreen, if available
    final args = Get.arguments;
    if (args != null) {
      cardNumber = args['card'] ?? '';
      expiryDate = args['expiry_date'] ?? '';
      cvv = args['cvv'] ?? '';

    }
    return  Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 17,
              color: blackTextColor,
            ),
          ),
        title:  Text(
          'Payment methods',
          style: AppTextStyles.largeAppBarText,
        )
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32,horizontal: 16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF7145D6)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Image.asset( height: 24, width: 24,'assets/images/green_cash.png'),
                  const SizedBox(width: 16,),
                   Text(
                    'Cash',
                    style:AppTextStyles.bodySmall.copyWith(
                      color: darkerGrey,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.check_circle,color: primaryColor,size: 14,),

                ],
              ),
            ),
            const SizedBox(height: 24),

            // Conditionally show Card Payment Container if card details exist
            if (cardNumber != null && cardNumber!.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF7145D6)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                     Image.asset(height: 8,width: 24,'assets/images/Visa.png'),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '**** **** **** ${cardNumber!.substring(cardNumber!.length - 4)}', // Show last 4 digits of card number
                          style:AppTextStyles.bodySmall.copyWith(
                           color: darkerGrey,
                          ),
                        ),
                         Text(
                          'Debit card',
                          style:AppTextStyles.bodySmall.copyWith(
                            color: disabledText,
                            fontSize: 10.0,
                          ),

                        )
                      ],
                    ),
                    const Spacer(),
                    Image.asset(width: 14,height: 14,'assets/images/card_ellipse.png'),
                  ],
                ),
              ),
            const SizedBox(height: 24,),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.addPaymentMethods);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                color: Colors.transparent,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outlined, color: primaryColor, size: 14),
                    SizedBox(width: 5),
                    Text(
                      'Add new payment method',
                      style:AppTextStyles.bodySmallPrimary.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}
