import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16,55,16,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              alignment: Alignment.center,
              height: 53,
                width: 53,
                'assets/images/insurance.png',
            ),
            SizedBox(height: 55,),
            Text(
                "Terms of Use & Privacy Notice",
              style: TextStyle(
                color: blackTextColor,
                fontFamily: 'br_omny_regular',
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 32,),
            Align(
              alignment: Alignment.center,
              child: Text(
                  "By tapping,”I Agree” below,\n you acknowledge having reviewed\n and agreed to the Terms of Useand the Privacy Notice of Taxi.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: blackTextColor,
                  fontFamily: 'br_omny_regular',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 431.0),
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
            SizedBox(height: 24,),
            Text(
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
