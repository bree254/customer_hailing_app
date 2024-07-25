import 'package:customer_hailing/components/phone_field/custom_phone_input.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
        child: Column(
          children: [
            Text(
              "What’s your mobile number?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: blackTextColor,
                fontFamily: 'br_omny_regular',
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 40),
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
            Spacer(),
            Padding(
              padding: EdgeInsets.zero,
              child: CustomElevatedButton(
                text: 'Continue',
                onPressed: (){},
                buttonTextStyle: const TextStyle(
                  color: whiteTextColor,
                  fontFamily: 'br_omny_regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                buttonStyle: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24,),
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
    );
  }
}
