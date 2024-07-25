import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:customer_hailing/widgets/custom_elevated_button.dart';
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
  final RxBool isButtonEnabled = false.obs;
  @override
  void initState() {
    super.initState();
    emailController.addListener(_onEmailChanged);
  }

  void _onEmailChanged() {
    isButtonEnabled.value = emailController.text.isNotEmpty;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
        child: Column(
          children: [
            Text(
              "What’s your email?",
              style: TextStyle(
                color: blackTextColor,
                fontFamily: 'br_omny_regular',
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Enter your email",
                    style: TextStyle(
                      color: formTextLabelColor,
                      fontFamily: 'br_omny_regular',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    final isFocused = emailController.text.isNotEmpty;
                    return CustomTextFormField(
                      controller: emailController,
                      filled: true,
                      fillColor: isFocused ? Colors.white : countryTextFieldColor,
                      borderDecoration: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: isFocused ? primaryColor : Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      hintText: "name@email.com",
                      hintStyle: const TextStyle(
                        color: blackTextColor,
                        fontFamily: 'br_omny_regular',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    );
                  }),
                  // Spacer(),
                  Obx(() {
                    return Padding(
                      padding: EdgeInsets.zero,
                      child: CustomElevatedButton(
                        text: 'Next',
                        onPressed: isButtonEnabled.value ? () {
                          Get.toNamed(AppRoutes.emailPhoneNumber);
                        } : null,
                        buttonTextStyle: const TextStyle(
                          color: whiteTextColor,
                          fontFamily: 'br_omny_regular',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor:isButtonEnabled.value
                              ? primaryColor
                              : disabledButtonGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                  const Text(
                    "Back",
                    style: TextStyle(
                      color: primaryColor,
                      fontFamily: 'br_omny_regular',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
