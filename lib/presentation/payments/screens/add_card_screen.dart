import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';

import '../../../routes/routes.dart';
import '../../../widgets/custom_text_form_field.dart';
class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController cardController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    cardController.addListener(_updateButtonState);
    expiryDateController.addListener(_updateButtonState);
    cvvController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = cardController.text.isNotEmpty;
      _isButtonEnabled = expiryDateController.text.isNotEmpty;
      _isButtonEnabled = cvvController.text.isNotEmpty;
    });
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      Get.toNamed(AppRoutes.paymentMethods, arguments: {
        'card': cardController.text,
        'expiry_date': expiryDateController.text,
        'cvv': cvvController.text,
      });
    }
  }

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
            'Add card',
            style: TextStyle(
              color: Color(0xFF767676),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32,horizontal: 16),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Card number',
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
                  controller: cardController,
                  filled: true,
                  fillColor: countryTextFieldColor,
                  prefix: const Icon(Icons.credit_card_outlined),
                  hintText: 'xxxx xxxx xxxx xxxx',
                  hintStyle: const TextStyle(
                    color: blackTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  autofocus: false,

                  contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Card Number is required';
                    }
                    return null;
                  },
                  borderDecoration: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.h),
                    borderSide: const BorderSide(color: Colors.transparent, width: 0),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Expiry date',
                                  style: TextStyle(
                                    color: Color(0xFF434343),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 50,),
                                Image.asset('assets/images/question_mark.png',height: 17,width: 17,)
                              ],
                            ),
                            const SizedBox(height: 10,),
                            CustomTextFormField(
                              controller: expiryDateController,
                              filled: true,
                              fillColor: countryTextFieldColor,
                              hintText: 'mm/yy',
                              hintStyle: const TextStyle(
                                color: blackTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              autofocus: false,
                              width: 164,

                              contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Date is required';
                                }
                                return null;
                              },
                              borderDecoration: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.h),
                                borderSide: const BorderSide(color: Colors.transparent, width: 0),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'CVV',
                                  style: TextStyle(
                                    color: Color(0xFF434343),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 100,),
                               Image.asset('assets/images/question_mark.png',height: 17,width: 17,)
                              ],
                            ),
                            const SizedBox(height: 10,),
                            CustomTextFormField(
                              controller: cvvController,
                              filled: true,
                              fillColor: countryTextFieldColor,
                              hintText: 'xxx',
                              hintStyle: const TextStyle(
                                color: blackTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              autofocus: false,
                              width: 164,
                              contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'CVV is required';
                                }
                                return null;
                              },
                              borderDecoration: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.h),
                                borderSide: const BorderSide(color: Colors.transparent, width: 0),
                              ),
                            ),
                          ],
                        ),

                      ],
                    )
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.zero,
                  child: CustomElevatedButton(
                    text: 'Add card',
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
                ),
              ],
            )),
      ),
    );
  }
}
