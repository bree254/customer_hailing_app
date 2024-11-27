import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:customer_hailing/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailSignInScreen extends StatefulWidget {
  const EmailSignInScreen({super.key});

  @override
  State<EmailSignInScreen> createState() => _EmailSignInScreenState();
}

class _EmailSignInScreenState extends State<EmailSignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  bool _isButtonEnabled = false;
  bool isShowPassword = false;

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
            const SizedBox(
              height: 32,
            ),
             Center(
              child: Text(
                "Sign in to your account",
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
          ],
        )),
      ),
    );
  }
}
