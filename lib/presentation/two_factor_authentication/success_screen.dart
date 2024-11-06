import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';

import '../../routes/routes.dart';
class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
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
              'assets/images/email_sent.png',
            ),
            const SizedBox(height: 55,),
             Text(
              "Terms of Use & Privacy Notice",
              style: AppTextStyles.largeAppBarText,
            ),
            const SizedBox(height: 32,),

             Align(
              alignment: Alignment.center,
              child: Text(
                'Please check your email and click on the link \nto reset your password',
                textAlign: TextAlign.center,
                style: AppTextStyles.titleTextField.copyWith(
                  fontSize: 12.0,
                ),
              )
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.zero,
              child: CustomElevatedButton(
                text: 'Open Email App',
                onPressed: (){
                  Get.toNamed(AppRoutes.resetPassword);
                },
                buttonStyle: ElevatedButton.styleFrom(
                  backgroundColor: whiteTextColor,
                  side: const BorderSide(color: primaryColor),
                  elevation: 0,
                ),
                buttonTextStyle:AppTextStyles.bodySmallPrimary.copyWith(
                  fontWeight: FontWeight.w500,
                ),

              ),
            ),

          ],

        ),
      ),
    );
  }
}
