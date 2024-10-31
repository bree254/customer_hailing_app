import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../routes/routes.dart';
import '../../../widgets/custom_text_form_field.dart';
class EmailSignUpScreen extends StatefulWidget {
  const EmailSignUpScreen({super.key});

  @override
  State<EmailSignUpScreen> createState() => _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends State<EmailSignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _isButtonEnabled = false;
  bool isShowPassword = false;
  bool isConfirmPassword = false;
  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
    confirmPasswordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = emailController.text.isNotEmpty;
      _isButtonEnabled = passwordController.text.isNotEmpty;
      _isButtonEnabled = confirmPasswordController.text.isNotEmpty;
    });
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {

      Get.toNamed(AppRoutes.detailsEmailSignUp, arguments: {
        'phone_email': emailController.text,
        "verification_type": "email"
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32,
                ),
                 Center(
                  child: Text(
                    "Sign up",
                    style: AppTextStyles.onBoardingAppBarText,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
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
                  labelText: "name@email.com",
                  labelStyle: const TextStyle(
                    color: blackTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  autofocus: false,
                  // height: 96.h,
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
                SizedBox(height: 20,),
                const Text(
                  "Enter your password",
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
                  controller: passwordController,
                  filled: true,
                  fillColor: countryTextFieldColor,
                  labelText: "Enter your new password",
                  labelStyle: const TextStyle(
                    color: blackTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  autofocus: false,
                  // height: 96.h,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
                  obscureText: !isShowPassword,
                  suffix: IconButton(
                    icon: Icon(
                      isShowPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 24,
                      color: appTheme.grayBlack,
                    ),
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                  ),
                  validator: (value) {
                    String? errorMessage = validatePassword(value);
                    return errorMessage;
                  },
                  onChanged: (value) {
                    setState(() {
                      _formKey.currentState!.validate();
                    });
                  },
                  borderDecoration: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.h),
                    borderSide: const BorderSide(color: Colors.transparent, width: 0),
                  ),
                ),
                SizedBox(height: 20,),
                const Text(
                  "Confirm your password",
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
                  controller: confirmPasswordController,
                  filled: true,
                  fillColor: countryTextFieldColor,
                  labelText: "Confirm password",
                  labelStyle: const TextStyle(
                    color: blackTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  autofocus: false,
                  // height: 96.h,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
                  obscureText: !isConfirmPassword,
                  suffix: IconButton(
                    icon: Icon(
                      isConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 24,
                      color: appTheme.grayBlack,
                    ),
                    onPressed: () {
                      setState(() {
                        isConfirmPassword = !isConfirmPassword;
                      });
                    },
                  ),
                  validator: (value) {
                    String? errorMessage = validatePassword(value);
                    return errorMessage;
                  },
                  onChanged: (value) {
                    setState(() {
                      _formKey.currentState!.validate();
                    });
                  },
                  borderDecoration: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.h),
                    borderSide: const BorderSide(color: Colors.transparent, width: 0),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.zero,
                  child: CustomElevatedButton(
                    text: 'Next',
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
                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: const Center(
                    child: Text(
                      "Back",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
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
