import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:customer_hailing/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class EmailSignInUpScreen extends StatefulWidget {
  const EmailSignInUpScreen({super.key});

  @override
  State<EmailSignInUpScreen> createState() => _EmailSignInUpScreenState();
}

class _EmailSignInUpScreenState extends State<EmailSignInUpScreen> {
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
      
      Get.toNamed(AppRoutes.emailPhoneNumber, arguments: {
        'phone_email': Get.arguments['email'],
        "verification_type": "email"
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
        child: Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            const Center(
              child: Text(
                "What’s your email?",
                style: TextStyle(
                  color: blackTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
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
              borderDecoration:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: "name@email.com",
              hintStyle: const TextStyle(
                color: blackTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
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
              onTap: (){},
              child: Center(
                child: const Text(
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
