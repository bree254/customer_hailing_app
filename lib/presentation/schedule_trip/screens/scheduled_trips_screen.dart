import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
class ScheduledTripsScreen extends StatefulWidget {
  const ScheduledTripsScreen({super.key});

  @override
  State<ScheduledTripsScreen> createState() => _ScheduledTripsScreenState();
}

class _ScheduledTripsScreenState extends State<ScheduledTripsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Scheduled Trips',
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
              Icons.arrow_back,
              size: 17,
              color: blackTextColor,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'You have not scheduled any trips',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20.v,),
              Text(
                'Tap on, “Schedule New Trip,” below to schedule your trip for a later time.',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: formTextLabelColor
                ),
              ),
              SizedBox(height: 40.v,),
              CustomElevatedButton(
                  text: 'Schedule New Trip',
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
              )
              
            ],

          ),
    )

    );
  }
}
