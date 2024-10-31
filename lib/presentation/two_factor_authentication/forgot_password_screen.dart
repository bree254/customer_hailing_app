import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_text_form_field.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = emailController.text.isNotEmpty;
    });
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      Get.toNamed(AppRoutes.success);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Text(
          'Forgot password',
          style: AppTextStyles.largeAppBarText,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.close,
            size: 17,
            color: blackTextColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter your email",
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
                  controller: emailController,
                  filled: true,
                  fillColor: countryTextFieldColor,
                  hintText: "name@email.com",
                  hintStyle: const TextStyle(
                    color: blackTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  autofocus: false,
                  height: 96.h,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                  borderDecoration: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.h),
                    borderSide: const BorderSide(color: Colors.transparent, width: 0),
                  ),
                ),
                const SizedBox(height: 83,),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child:  const Center(
                    child:Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Remembered your password?',
                            style: TextStyle(
                              color: Color(0xFF434343),
                              fontSize: 12,
                              fontFamily: 'BR Omny',
                              fontWeight: FontWeight.w400,
                              height: 0.14,
                              letterSpacing: 0.25,
                            ),
                          ),
                          TextSpan(
                            text: ' Login',
                            style: TextStyle(
                              color: Color(0xFF7145D6),
                              fontSize: 12,
                              fontFamily: 'BR Omny',
                              fontWeight: FontWeight.w400,
                              height: 0.14,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.right,
                    )
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.zero,
                  child: CustomElevatedButton(
                    text: 'Reset Password',
                    onPressed: _isButtonEnabled
                        ? () {
                            Get.toNamed(AppRoutes.success);
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
