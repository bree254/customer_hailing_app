import 'package:customer_hailing/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../routes/routes.dart';
class ScheduleNewTripScreen extends StatefulWidget {
  const ScheduleNewTripScreen({super.key});

  @override
  State<ScheduleNewTripScreen> createState() => _ScheduleNewTripScreenState();
}

class _ScheduleNewTripScreenState extends State<ScheduleNewTripScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Text(
          'Schedule New Trip',
          style: AppTextStyles.onBoardingAppBarText,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Select date of trip',
              style: AppTextStyles.titleTextField.copyWith(
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 10.v,),
            CustomTextFormField(
              controller: dateController,
              filled: true,
              fillColor: countryTextFieldColor,
              prefix: const Icon(Icons.calendar_month_outlined),
              hintText: "name@email.com",
              hintStyle: AppTextStyles.textFieldHint,
              autofocus: false,
              height: 96.h,
              contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
              borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.h),
                borderSide: const BorderSide(color: Colors.transparent, width: 0),
              ),
            ),
             Text(
              'Select request time',
              style: AppTextStyles.titleTextField.copyWith(
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 10.v,),
            CustomTextFormField(
              controller: dateController,
              filled: true,
              fillColor: countryTextFieldColor,
              prefix: const Icon(Icons.access_time),
              hintStyle: AppTextStyles.textFieldHint,
              autofocus: false,
              height: 96.h,
              contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
              borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.h),
                borderSide: const BorderSide(color: Colors.transparent, width: 0),
              ),
            ),
            const Spacer(),
            CustomElevatedButton(
              onPressed: (){
                Get.toNamed(AppRoutes.enterScheduleTripDetails);
              },
              text: 'Next',
              buttonStyle: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                elevation: 0,
              ),
              buttonTextStyle: AppTextStyles.bodySmallBold.copyWith(
                color: whiteTextColor,
              ),
            ),
            SizedBox(height: 20.v,),
            CustomElevatedButton(
              onPressed: (){
                Get.back();
              },
              text: 'Cancel',
              buttonStyle: ElevatedButton.styleFrom(
                backgroundColor: whiteTextColor,
                side: const BorderSide(color: primaryColor),
                elevation: 0,
              ),
              buttonTextStyle: AppTextStyles.bodySmallPrimary.copyWith(
                fontWeight: FontWeight.w500,
              ),

            ),
            SizedBox(height: 20.v,),
          ],
        ),
      ),
    );
  }
}
