import 'package:customer_hailing/presentation/order_request/models/data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/app_export.dart';
import '../../../data/repos/ride_service_repository.dart';
import '../../../routes/routes.dart';
import '../../order_request/controller/ride_service_controller.dart';

class ScheduledTripsScreen extends StatefulWidget {
  const ScheduledTripsScreen({super.key});

  @override
  State<ScheduledTripsScreen> createState() => _ScheduledTripsScreenState();
}

class _ScheduledTripsScreenState extends State<ScheduledTripsScreen> {
  final RideServiceController controller = Get.put(RideServiceController(rideServiceRepository: RideServiceRepository()));

  String formatDateTime(String dateTime) {
    final DateTime parsedDateTime = DateTime.parse(dateTime);
    final DateFormat formatter = DateFormat('d MMM yyyy - h:mm a');
    return formatter.format(parsedDateTime);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Scheduled Trips',
          style: AppTextStyles.largeAppBarText,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 17,
            color: blackTextColor,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.scheduledTrips == null || controller.scheduledTrips.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'You have not scheduled any trips',
                  style: AppTextStyles.bodyHeading.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Tap on, “Schedule New Trip,” below to schedule your trip for a later time.',
                  style: AppTextStyles.bodyHeading.copyWith(
                    fontWeight: FontWeight.w500,
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
                  buttonTextStyle: AppTextStyles.bodySmallPrimary.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        } else {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            itemCount: controller.scheduledTrips.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              final scheduledTrip = controller.scheduledTrips[index];

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
                  formatDateTime(scheduledTrip.scheduledTime.toString()),
                  style: AppTextStyles.listTileTitle.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From : ${scheduledTrip.pickupLocation!.address.toString()}',
                      style: AppTextStyles.listTileSubtitle,
                    ),
                    Text(
                      'To : ${scheduledTrip.dropOffLocation!.address.toString()}',
                      style: AppTextStyles.listTileSubtitle,
                    ),
                  ],
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
                onTap: () {
                  //Get.toNamed(AppRoutes.tripDetails);
                  Get.toNamed(AppRoutes.tripDetails, arguments: scheduledTrip.id);
                },
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.scheduleNewTrip);
        },
        child: const Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
    );
  }
}