import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../routes/routes.dart';
import '../../widgets/custom_text_form_field.dart';
import '../order_request/models/data.dart';
import 'controllers/promotions_controller.dart';
class PromotionsScreen extends StatefulWidget {
  const PromotionsScreen({super.key});

  @override
  State<PromotionsScreen> createState() => _PromotionsScreenState();
}

class _PromotionsScreenState extends State<PromotionsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController promoController = TextEditingController();
  bool _isButtonEnabled = false;

  final PromoController controller = Get.put(PromoController());

  @override

  @override
  void initState() {
    super.initState();
    promoController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = promoController.text.isNotEmpty;
    });
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Promotions',
          style: TextStyle(
            color: Color(0xFF767676),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
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
      ),
      body: MyData.promotions.isEmpty
          ? Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            const Text(
              "Promo code",
              style: TextStyle(
                color: formTextLabelColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              controller: promoController,
              filled: true,
              fillColor: countryTextFieldColor,
              hintText: "Enter your promo code",
              hintStyle: const TextStyle(
                color: blackTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              autofocus: false,
              height: 96.h,
              contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
              borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.h),
                borderSide: const BorderSide(color: Colors.transparent, width: 0),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.zero,
              child: CustomElevatedButton(
                text: 'Activate',
                onPressed: _isButtonEnabled
                    ? () {
                  onSubmit();
                }
                    : null,
                buttonStyle: ElevatedButton.styleFrom(
                  backgroundColor:
                  _isButtonEnabled ? primaryColor : disabledButtonGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            )
            ]
        )
        )
      )
          : Padding(padding: EdgeInsets.symmetric())
    );
  }
}
