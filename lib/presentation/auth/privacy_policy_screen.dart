import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:customer_hailing/theme/app_text_styles.dart';
import 'package:customer_hailing/widgets/custom_elevated_button.dart';
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
            SizedBox(height: 55,),
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
            const Align(
              alignment: Alignment.center,
              child: Text(
                  "By tapping,”I Agree” below,you acknowledge\n having reviewed and agreed to the Terms of Use\n and the Privacy Notice of Taxi.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: blackTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.zero,
              child: CustomElevatedButton(
                text: 'Continue',
                onPressed: (){
                  // Get.toNamed(AppRoutes.home);
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
        
        ),
      ),
    );
  }
}
