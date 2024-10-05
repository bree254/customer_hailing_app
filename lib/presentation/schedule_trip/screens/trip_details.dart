import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../widgets/custom_stepper_widget.dart';
class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Trip Details',
          style: TextStyle(
            color: Color(0xFF767676),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.close,
            size: 17,
            color: blackTextColor,
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 24),
        child: Column(
          children: [
            Container(
              height: 47.v,
              margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 8.h),
              decoration: BoxDecoration(
                  color: selectRideColor,
                  borderRadius: BorderRadius.all(Radius.circular(8.h))),
              child: Row(
                children: [
                  const Icon(
                    Icons.info,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 280.h,
                    child: Text(
                      'Changing of trip details will lead to cost recalculation',
                      style: TextStyle(
                        color: Color(0xFF7145D6),
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0.15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32,),
            CustomStepper(
              steps: [
                CustomStep(
                  title: 'From',
                  subtitle: 'GPO Stage, Kenyatta Avenue',
                  onEdit: () {
                    // handle edit for 'From' location
                  },
                ),
                CustomStep(
                  title: 'To',
                  subtitle: 'Mövenpick Residences Nairobi',
                  onEdit: () {
                    // handle edit for 'To' location
                  },
                ),
              ],
              activeStep: 1, // You can adjust this based on your logic
            ),

            Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),
            ListTile(
              title: Text(
                'Date of trip',
                style: TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle:Text(
                '12 August, 2024',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Text(
                'Change',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF7145D6),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              )
            ),
            SizedBox(height: 32,),

            ListTile(
                title: Text(
                  'Request time',
                  style: TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle:Text(
                  '08:00 PM',
                  style: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Text(
                  'Change',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF7145D6),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
            ),
            SizedBox(height: 32,),

            ListTile(
                title: Text(
                  'Vehicle type',
                  style: TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle:Text(
                  'Economy (3 seats)',
                  style: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Text(
                  'Change',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF7145D6),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
            ),
            SizedBox(height: 32,),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),
            ListTile(
                title: Text(
                  'Estimated cost',
                  style: TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Text(
                  'KES 460',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )
            ),

           Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: CustomElevatedButton(
                onPressed: (){
                  Get.back();
                },
                text: 'Cancel Trip',
                buttonStyle: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: BorderSide(color: primaryColor),
                  elevation: 0,
                ),
                buttonTextStyle: const TextStyle(
                  color: primaryColor,
                  fontSize: 12,
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
