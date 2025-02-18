import 'package:customer_hailing/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        timeController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Schedule New Trip',
          style: AppTextStyles.onBoardingAppBarText,
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            size: 17,
            color: blackTextColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select date of trip',
              style: AppTextStyles.titleTextField.copyWith(
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 10.v),
            CustomTextFormField(
              controller: dateController,
              filled: true,
              fillColor: countryTextFieldColor,
              prefix: GestureDetector(
                onTap: () => _selectDate(context),
                child: const Icon(Icons.calendar_month_outlined),
              ),
              hintText: "Select date",
              hintStyle: AppTextStyles.textFieldHint,
              autofocus: false,
              height: 96.h,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
              borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.h),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0),
              ),
            ),
            Text(
              'Select request time',
              style: AppTextStyles.titleTextField.copyWith(
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 10.v),
            CustomTextFormField(
              controller: timeController,
              filled: true,
              fillColor: countryTextFieldColor,
              prefix: GestureDetector(
                onTap: () => _selectTime(context),
                child: const Icon(Icons.access_time),
              ),
              hintText: "Select time",
              hintStyle: AppTextStyles.textFieldHint,
              autofocus: false,
              height: 96.h,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
              borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.h),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0),
              ),
            ),
            const Spacer(),
            CustomElevatedButton(
              onPressed: () {
                Get.toNamed(
                  AppRoutes.enterScheduleTripDetails,
                  arguments: {
                    'date': dateController.text,
                    'time': timeController.text,
                  },
                );
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
            SizedBox(height: 20.v),
            CustomElevatedButton(
              onPressed: () {
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
            SizedBox(height: 20.v),
          ],
        ),
      ),
    );
  }
}
