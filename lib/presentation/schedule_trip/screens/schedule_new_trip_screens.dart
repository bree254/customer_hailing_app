import 'package:customer_hailing/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

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
        title: const Text(
          'Schedule New Trip',
          style: TextStyle(
            color: Color(0xFF767676),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 24,horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select date of trip',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 10.v,),
            CustomTextFormField(
              controller: dateController,
              filled: true,
              fillColor: countryTextFieldColor,
              prefix: Icon(Icons.calendar_month_outlined),
              hintText: "name@email.com",
              hintStyle: const TextStyle(
                color: blackTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
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
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 10.v,),
            CustomTextFormField(
              controller: dateController,
              filled: true,
              fillColor: countryTextFieldColor,
              prefix: Icon(Icons.access_time),
              hintStyle: const TextStyle(
                color: blackTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              autofocus: false,
              height: 96.h,
              contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
              borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.h),
                borderSide: const BorderSide(color: Colors.transparent, width: 0),
              ),
            ),
            Spacer(),
            CustomElevatedButton(
              onPressed: (){
                Get.toNamed(AppRoutes.search);
              },
              text: 'Next',
              buttonStyle: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                elevation: 0,
              ),
              buttonTextStyle: const TextStyle(
                color: whiteTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.v,),
            CustomElevatedButton(
              onPressed: (){
                Get.toNamed(AppRoutes.search);
              },
              text: 'Cancel',
              buttonStyle: ElevatedButton.styleFrom(
                backgroundColor: whiteTextColor,
                side: BorderSide(color: primaryColor),
                elevation: 0,
              ),
              buttonTextStyle: const TextStyle(
                color: primaryColor,
                fontSize: 12,
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
