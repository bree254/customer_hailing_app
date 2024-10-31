import 'package:customer_hailing/presentation/order_request/models/data.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../routes/routes.dart';

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
          title:  Text(
            'Scheduled Trips',
            style: AppTextStyles.largeAppBarText,
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
      body: MyData.trips.isEmpty
          ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'You have not scheduled any trips',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Tap on, “Schedule New Trip,” below to schedule your trip for a later time.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: formTextLabelColor,
              ),
            ),
            const SizedBox(height: 40.0),
            CustomElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.scheduleNewTrip);
              },
              text: 'Schedule New Trip',
              buttonStyle: ElevatedButton.styleFrom(
                backgroundColor: whiteTextColor,
                side: const BorderSide(color: primaryColor),
                elevation: 0,
              ),
              buttonTextStyle: const TextStyle(
                color: primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        itemCount: MyData.trips.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey[300],
          thickness: 1,
        ),
        itemBuilder: (context, index) {
          final trip = MyData.trips[index];
          return ListTile(
            leading: Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFD1D5DB),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.calendar_month_outlined,
                  size: 16,
                  color: Colors.black,
                ),
              ),
            ),
            title: Text(
              trip['dateTime'] ?? '',
              style: const TextStyle(
                color: Color(0xFF555555),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'From: ${trip['from'] ?? ''}',
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'To: ${trip['to'] ?? ''}',
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
            onTap: () {
             Get.toNamed(AppRoutes.tripDetails);
            },
          );
        },
      ),
    );
  }
}
