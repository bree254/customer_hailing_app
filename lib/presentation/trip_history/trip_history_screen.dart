import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/order_request/controller/ride_service_controller.dart';
import 'package:customer_hailing/presentation/order_request/models/data.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/repos/ride_service_repository.dart';

class TripHistoryScreen extends StatefulWidget {
  const TripHistoryScreen({super.key});

  @override
  State<TripHistoryScreen> createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
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
          'History',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        child: Obx(() {
          if (controller.history.value.data == null || controller.history.value.data!.isEmpty) {
            return Center(
              child: Text(
                'No trip history available',
                style: AppTextStyles.listTileTitle,
              ),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
              itemCount: controller.history.value.data!.length,
              itemBuilder: (context, index) {
                final history = controller.history.value.data?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFD1D5DB),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(height: 5, width: 5, 'assets/images/map_pin_outline.png'),
                      ),
                    ),
                    title: Text(
                      history?.destination ?? '',
                      style: AppTextStyles.listTileTitle,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          history != null ? formatDateTime(history.date.toString()) : '',
                          style: AppTextStyles.listTileSubtitle,
                        ),
                        Text(
                          history?.amount.toString() ?? '780',
                          style: AppTextStyles.listTileSubtitle,
                        ),
                      ],
                    ),
                    onTap: () {
                      Get.toNamed(AppRoutes.historyDetails);
                    },
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}