import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/custom_text_form_field.dart';
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _isButtonEnabled = false;

  bool isShowPassword = false;

  bool emailIsValid = false;

  @override
  void initState() {
    super.initState();
    oldPasswordController.addListener(_updateButtonState);
    newPasswordController.addListener(_updateButtonState);
    confirmPasswordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = oldPasswordController.text.isNotEmpty;
      _isButtonEnabled = newPasswordController.text.isNotEmpty;
      _isButtonEnabled = confirmPasswordController.text.isNotEmpty;
    });
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {

    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Change Password',
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // old password
                const Text(
                  "Old Password",
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
                  controller: oldPasswordController,
                  filled: true,
                  fillColor: countryTextFieldColor,
                  hintText: "Enter your old password",
                  hintStyle: const TextStyle(
                    color: blackTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  autofocus: false,
                  height: 96.h,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
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
                        isShowPassword = isShowPassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  borderDecoration: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.h),
                    borderSide: const BorderSide(color: Colors.transparent, width: 0),
                  ),
                ),

                // new password

                const Text(
                  "New Password",
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
                  controller: newPasswordController,
                  filled: true,
                  fillColor: countryTextFieldColor,
                  hintText: "Enter your new password",
                  hintStyle: const TextStyle(
                    color: blackTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  autofocus: false,
                  height: 96.h,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
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
                        isShowPassword = isShowPassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  borderDecoration: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.h),
                    borderSide: const BorderSide(color: Colors.transparent, width: 0),
                  ),
                ),

                // confirm password

                const Text(
                  "Confirm Password",
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
                  hintText: "Confirm your new password",
                  hintStyle: const TextStyle(
                    color: blackTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  autofocus: false,
                  height: 96.h,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
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
                        isShowPassword = isShowPassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  borderDecoration: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.h),
                    borderSide: const BorderSide(color: Colors.transparent, width: 0),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: const Center(
                    child: Text(
                      "Forgot Password ?",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.zero,
                  child: CustomElevatedButton(
                    text: 'Change Password',
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
