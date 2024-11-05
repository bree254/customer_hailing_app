import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:customer_hailing/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailSignInUpScreen extends StatefulWidget {
  const EmailSignInUpScreen({super.key});

  @override
  State<EmailSignInUpScreen> createState() => _EmailSignInUpScreenState();
}

class _EmailSignInUpScreenState extends State<EmailSignInUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isButtonEnabled = false;
  bool isShowPassword = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = emailController.text.isNotEmpty;
      _isButtonEnabled = passwordController.text.isNotEmpty;
    });
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      
      Get.toNamed(AppRoutes.verification, arguments: {
        'phone_email': emailController.text,
        "verification_type": "email"
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "Login to your account",
                style: AppTextStyles.onBoardingAppBarText,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
             Text(
              "Enter your email",
              style: AppTextStyles.text14FormLabel400,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              controller: emailController,
              filled: true,
              fillColor: countryTextFieldColor,
              labelText: "name@email.com",
              labelStyle: AppTextStyles.text14Black400,
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
             Text(
              "Enter your password",
              style: AppTextStyles.text14FormLabel400,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              controller: passwordController,
              filled: true,
              fillColor: countryTextFieldColor,
              labelText: "Enter your new password",
              labelStyle:  AppTextStyles.text14Black400,
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
            Padding(
              padding: const EdgeInsets.only(left: 180.0),
              child: GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.forgotPassword);
                },
                child:  Center(
                  child: Text(
                    "Forgot password?",
                    style: AppTextStyles.forgotPasswordText,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32,),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.emailSignUp);
                },
                child:  Center(
                  child: RichText(
                      text: TextSpan(
                        text:"Don’t have an account?",
                          style: AppTextStyles.forgotPasswordText.copyWith(color: blackTextColor),
                        children: [
                          TextSpan(
                          text:" Sign up ",
                            style: AppTextStyles.forgotPasswordText,)
                        ]
                      ),
                  ),
                ),
              ) ,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.zero,
              child: CustomElevatedButton(
                text: 'Log in',
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
