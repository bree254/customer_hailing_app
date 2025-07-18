import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';

class AddNewPaymentScreen extends StatefulWidget {
  const AddNewPaymentScreen({super.key});

  @override
  State<AddNewPaymentScreen> createState() => _AddNewPaymentScreenState();
}

class _AddNewPaymentScreenState extends State<AddNewPaymentScreen> {
  @override
  Widget build(BuildContext context) {
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
          title: const Text(
            'Payment methods',
            style: TextStyle(
              color: Color(0xFF767676),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32,horizontal: 16),
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.addCard);
              },
              child: Container(
                width: double.infinity,
                height: 56,
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF555555)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset( height: 24, width: 24,'assets/images/credit_card.png'),
                    const SizedBox(width: 16,),
                    const Text(
                      'Credit or Debit Card',
                      style: TextStyle(
                        color: Color(0xFF555555),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
