import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16,55,16,16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 55,),
            Image.asset(
              alignment: Alignment.center,
              height: 53,
                width: 53,
                'assets/images/insurance.png',
            ),
            const SizedBox(height: 55,),
            const Text(
                "Terms of Use & Privacy Notice",
              style: TextStyle(
                color: blackTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 32,),

             Align(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'By tapping, “I Agree” below, you acknowledge\n having reviewed and agreed to the ',
                  style: TextStyle(
                    color: blackTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms of Use',
                      style: TextStyle(
                        fontFamily: "",
                        color: primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: ' and the ',
                      style: TextStyle(
                        color: blackTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Notice',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: ' of Taxi.',
                      style: TextStyle(
                        color: blackTextColor, // Replace with your desired text color
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],

                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.zero,
              child: CustomElevatedButton(
                text: 'Continue',
                onPressed: (){
                  Get.toNamed(AppRoutes.home);
                },

                buttonTextStyle: AppTextStyles.titleMedium.copyWith(color: whiteTextColor),
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
        
        ),
      ),
    );
  }
}
