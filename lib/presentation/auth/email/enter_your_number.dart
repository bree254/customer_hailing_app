import 'package:customer_hailing/components/phone_field/custom_phone_input.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../routes/routes.dart';
class EmailPhoneNumberScreen extends StatefulWidget {
  const EmailPhoneNumberScreen({super.key});

  @override
  State<EmailPhoneNumberScreen> createState() => _EmailPhoneNumberScreenState();
}

class _EmailPhoneNumberScreenState extends State<EmailPhoneNumberScreen> {

  String? errorMessage;
  InputBorder? inputBorder;

  TextEditingController phoneController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments from the previous screen
    final arguments = Get.arguments;
    final String phoneEmail = arguments['phone_email'] ?? '';
    final String verificationType = arguments['verification_type'] ?? '';

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
          child: Column(
            children: [
              const SizedBox(height: 32,),
              const Text(
                "What’s your mobile number?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: blackTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 40),
              CustomPhoneInput(
                controller: phoneController,
                onInputChanged: (value) {
                  String? newErrorMessage;
                  InputBorder newInputBorder;

                  if (value.length == 9) {
                    newErrorMessage = null;
                    newInputBorder = OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.h),
                      borderSide: BorderSide(color: appTheme.colorPrimary),
                    );
                  } else {
                    newErrorMessage = 'Incomplete number';
                    newInputBorder = OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.h),
                      borderSide: BorderSide(color: appTheme.inputError),
                    );
                  }
                  setState(() {
                    errorMessage = newErrorMessage;
                    inputBorder = newInputBorder;
                  });
                },
                inputBorder: inputBorder,
                errorMessage: errorMessage,
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.zero,
                child: CustomElevatedButton(
                  text: 'Continue',
                  onPressed: () {
                    // Navigate to the next screen, passing the email and phone number
                    Get.toNamed(AppRoutes.verification, arguments: {
                      'phone_email': phoneEmail,
                      'verification_type':verificationType,
                      // 'phone_number': phoneController.text,

                    });
                  },
                  buttonStyle: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24,),
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: const Text(
                  "Back",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),

            ],
          ),
      ),
    );
  }
}
