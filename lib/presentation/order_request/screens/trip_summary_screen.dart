import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class TripSummaryScreen extends StatefulWidget {
  const TripSummaryScreen({super.key});

  @override
  State<TripSummaryScreen> createState() => _TripSummaryScreenState();
}

class _TripSummaryScreenState extends State<TripSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 100, 24, 24),
        child: Column(
          children: [
             SizedBox(
              width: 255,
              child: Text(
                '5th, August, 2024',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: searchtextGrey,
                ),


              ),
            ),
            const SizedBox(
              height: 8,
            ),
             SizedBox(
              width: 255,
              child: Text(
                'Thank you for riding, Ariana',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: searchtextGrey,
                  fontSize: 20.0,
                ),


              ),
            ),
            const SizedBox(
              height: 74,
            ),
             SizedBox(
              width: 124,
              child: Text(
                'Total',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: searchtextGrey,
                ),

              ),
            ),
             Text(
              'KES 290',
              textAlign: TextAlign.center,
              style:AppTextStyles.bodyHeading.copyWith(
                color:primaryColor,
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),

            ),
            const SizedBox(
              height: 74,
            ),
            Divider(
              color: Colors.grey[100],
            ),
             ListTile(
              leading: Text(
                'Distance',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: searchtextGrey,
                ),
              ),
              trailing: Text(
                'KES 150.00',
                textAlign: TextAlign.right,
                style: AppTextStyles.bodySmall.copyWith(
                  color: searchtextGrey,
                ),
              ),
            ),
             ListTile(
              leading: Text(
                'Time',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: searchtextGrey,
                ),
              ),
              trailing: Text(
                'KES 150.00',
                textAlign: TextAlign.right,
                style: AppTextStyles.bodySmall.copyWith(
                  color: searchtextGrey,
                ),
              ),
            ),
             ListTile(
              leading: Text(
                'Base fare',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: searchtextGrey,
                ),
              ),
              trailing: Text(
                'KES 150.00',
                textAlign: TextAlign.right,
                style: AppTextStyles.bodySmall.copyWith(
                  color: searchtextGrey,
                ),
              ),
            ),
            Divider(
              color: Colors.grey[100],
            ),
             ListTile(
              leading: Text(
                'Normal fare',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: searchtextGrey,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Text(
                'KES 150.00',
                textAlign: TextAlign.right,
                style: AppTextStyles.bodySmall.copyWith(
                  color: searchtextGrey,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text(
                    'Surge',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: searchtextGrey,
                    ),
                  ),
                  SizedBox(width: 16,),
                  Image.asset('assets/images/question_mark.png',height: 12,width: 12,color: primaryColor,)
                ],
              ),
              trailing:  Text(
                'KES 150.00',
                textAlign: TextAlign.right,
                style: AppTextStyles.bodySmall.copyWith(
                  color: searchtextGrey,
                ),
              ),
            ),
            ListTile(
              leading:
               Text(
                'Tip',
                textAlign: TextAlign.center,
                 style: AppTextStyles.bodySmall.copyWith(
                   color: searchtextGrey,
                 ),
              ),
              trailing:  Text(
                'KES 150.00',
                textAlign: TextAlign.right,
                style: AppTextStyles.bodySmall.copyWith(
                  color: searchtextGrey,
                ),
              ),
            ),
            Divider(
              color: Colors.grey[100],
            ),
             ListTile(
              leading: Text(
                'Subtotal',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: searchtextGrey,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Text(
                'KES 150.00',
                textAlign: TextAlign.right,
                style: AppTextStyles.bodySmall.copyWith(
                  color: searchtextGrey,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Spacer(),
            CustomElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: Get.context!,
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 32, horizontal: 32),
                        width: double.infinity,
                        height: 280,
                        clipBehavior: Clip.antiAlias,
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(Icons.close),
                              ),
                            ),
                             Text(
                              'Tip your driver',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyHeading.copyWith(
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            CustomTextFormField(
                              width: 149,
                              labelText: 'Enter your amount',
                              filled: true,
                              fillColor: countryTextFieldColor,
                              autofocus: false,
                              contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
                              borderDecoration: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.h),
                                borderSide: const BorderSide(color: Colors.transparent, width: 0),
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            CustomElevatedButton(
                              onPressed: () {
                              },
                              text: 'Continue',
                              buttonStyle: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                elevation: 0,
                              ),
                              buttonTextStyle: AppTextStyles.bodySmallBold.copyWith(
                                color: whiteTextColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              text: 'Tip Driver?',
              buttonStyle: ElevatedButton.styleFrom(
                backgroundColor: whiteTextColor,
                side: const BorderSide(color: primaryColor),
                elevation: 0,
              ),
              buttonTextStyle: AppTextStyles.bodySmallPrimary.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
