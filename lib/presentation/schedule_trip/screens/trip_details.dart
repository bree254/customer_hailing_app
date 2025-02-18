import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/repos/ride_service_repository.dart';
import '../../../widgets/custom_stepper_widget.dart';
import '../../order_request/controller/ride_service_controller.dart';
class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  final RideServiceController controller = Get.put(RideServiceController(rideServiceRepository: RideServiceRepository()));
  String formatDateTime(String dateTime) {
    final DateTime parsedDateTime = DateTime.parse(dateTime);
    final DateFormat formatter = DateFormat('d MMM yyyy - h:mm a');
    return formatter.format(parsedDateTime);
  }

  String formatDate(String dateTime) {
    final DateTime parsedDateTime = DateTime.parse(dateTime);
    final DateFormat dateFormatter = DateFormat('d MMM yyyy');
    return dateFormatter.format(parsedDateTime);
  }

  String formatTime(String dateTime) {
    final DateTime parsedDateTime = DateTime.parse(dateTime);
    final DateFormat timeFormatter = DateFormat('h:mm a');
    return timeFormatter.format(parsedDateTime);
  }

  @override
  void initState() {
    super.initState();
    final String tripId = Get.arguments as String;
    controller.getScheduledTripDetails(tripId);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Text(
          'Trip Details',
          style: AppTextStyles.largeAppBarText,
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
      body: Obx(() {
        if (controller.scheduledTripDetails.value == null) {
          return Center(child: CircularProgressIndicator(

          ));
        } else {
          //final tripDetails = controller.scheduledTripDetails.value!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                Container(
                  height: 47.v,
                  margin: EdgeInsets.symmetric(
                      horizontal: 16.h, vertical: 10.h),
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
                          style: AppTextStyles.bodySmall.copyWith(
                            color: primaryColor,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32,),
                CustomStepper(
                  steps: [
                    CustomStep(
                      title: 'From',
                      subtitle: controller.scheduledTripDetails.value
                          .pickupLocation!.address.toString(),
                      onEdit: () {
                        // handle edit for 'From' location
                      },
                    ),
                    CustomStep(
                      title: 'To',
                      subtitle: controller.scheduledTripDetails.value
                          .dropOffLocation!.address.toString(),
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
                      style: AppTextStyles.listTileTitle,
                    ),
                    subtitle: Text(
                      formatDate(
                          controller.scheduledTripDetails.value.scheduledTime
                              .toString()),
                      style: AppTextStyles.listTileSubtitle,
                    ),
                    trailing: Text(
                      'Change',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.listTileTrailing,

                    )
                ),
                const SizedBox(height: 32,),

                ListTile(
                    title: Text(
                      'Request time',
                      style: AppTextStyles.listTileTitle,
                    ),
                    subtitle: Text(
                      formatTime(
                          controller.scheduledTripDetails.value.scheduledTime
                              .toString()),
                      style: AppTextStyles.listTileSubtitle,
                    ),
                    trailing: Text(
                      'Change',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.listTileTrailing,
                    )
                ),
                const SizedBox(height: 32,),

                ListTile(
                    title: Text(
                      'Vehicle type',
                      style: AppTextStyles.listTileTitle,
                    ),
                    subtitle: Text(
                      controller.scheduledTripDetails.value.vehicleCategory!
                          .toString(),
                      style: AppTextStyles.listTileSubtitle,
                    ),
                    trailing: Text(
                      'Change',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.listTileTrailing,
                    )
                ),
                const SizedBox(height: 32,),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                ),
                ListTile(
                    title: Text(
                      'Estimated cost',
                      style: AppTextStyles.listTileTitle.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Text(
                      'KES ${ controller.scheduledTripDetails.value.estimatedFare!
                          .toString()}',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.listTileTitle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    )
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: CustomElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    text: 'Cancel Trip',
                    buttonStyle: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(color: primaryColor),
                      elevation: 0,
                    ),
                    buttonTextStyle: AppTextStyles.bodySmallPrimary.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

              ],

            ),
          );
        }
      }
    ),
    );
  }
}
