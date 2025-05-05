import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/order_request/controller/ride_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../routes/routes.dart';

class AwaitDriverBottomsheetWidget extends StatelessWidget {
  AwaitDriverBottomsheetWidget({super.key});

  final RideServiceController rideServiceController = Get.find<RideServiceController>();

  Widget _buildStatusContent(BuildContext context) {
    return Obx(() {
      final status = rideServiceController.tripDetails.value.tripStatus;

      switch (status) {
        case 'REQUESTED':
          return _buildSearchingContent(context);
        case 'SCHEDULED':
          return _buildConnectingContent();
        case 'NEEDS_REASSIGNMENT':
          return _buildLookingForAnotherContent(context);
        default:
          return _buildSearchingContent(context);
      }
    });
  }

  Widget _buildSearchingContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60.0),
            child: LinearProgressIndicator(
              minHeight: 4,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          "Searching for nearby drivers",
          style: AppTextStyles.bodyMediumPrimary.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Sit tight as we get the nearest available driver for you!',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            color: resendCodeTextColor,
          ),
        ),
        const SizedBox(height: 22),
       CustomElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Cancel ride request?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Your ride request is still being processed. Canceling now will stop the search for a driver.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child:  CustomElevatedButton(
                            onPressed: () {
                              rideServiceController.canceltrip();
                              Get.toNamed(AppRoutes.home);
                            },
                            buttonStyle: ElevatedButton.styleFrom(
                              backgroundColor: cancelButton,
                              elevation: 0,
                            ),
                            buttonTextStyle: AppTextStyles.bodySmallBold.copyWith(
                              color: cancelText,
                            ),
                            text: 'Confirm',
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            buttonStyle: ElevatedButton.styleFrom(
                              backgroundColor: countryTextFieldColor,
                              elevation: 0,
                            ),
                            buttonTextStyle: AppTextStyles.bodySmallBold.copyWith(
                              color: resendCodeTextColor,

                            ),
                            text: 'Continue searching',
                          ),

                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: cancelButton,
            elevation: 0,
          ),
          buttonTextStyle: AppTextStyles.bodySmallBold.copyWith(
            color: cancelText,
          ),
          text: 'Cancel',
        )
      ],
    );
  }

  Widget _buildConnectingContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
            child: Text(
              "Connecting you to your driver",
              style: AppTextStyles.bodyMediumPrimary.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: 150.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: 100.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 5),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 138,
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: ShapeDecoration(
                    color: const Color(0xBFE2E2E2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 138,
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: ShapeDecoration(
                    color: const Color(0xBFE2E2E2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLookingForAnotherContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60.0),
            child: LinearProgressIndicator(
              minHeight: 4,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          "Looking for another driver",
          style: AppTextStyles.bodyMediumPrimary.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Center(
            child: Text(
              "Your previous driver did not confirm your request",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                color: resendCodeTextColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 22),
        CustomElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Cancel ride request?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Your ride request is still being processed. Canceling now will stop the search for a driver.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child:  CustomElevatedButton(
                            onPressed: () {
                              rideServiceController.canceltrip();
                              Get.toNamed(AppRoutes.home);
                            },
                            buttonStyle: ElevatedButton.styleFrom(
                              backgroundColor: cancelButton,
                              elevation: 0,
                            ),
                            buttonTextStyle: AppTextStyles.bodySmallBold.copyWith(
                              color: cancelText,
                            ),
                            text: 'Confirm',
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            onPressed: () {
                               Navigator.pop(context);
                            },
                            buttonStyle: ElevatedButton.styleFrom(
                              backgroundColor: countryTextFieldColor,
                              elevation: 0,
                            ),
                            buttonTextStyle: AppTextStyles.bodySmallBold.copyWith(
                              color: resendCodeTextColor,
                            ),
                            text: 'Continue searching',
                          ),

                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: cancelButton,
            elevation: 0,
          ),
          buttonTextStyle: AppTextStyles.bodySmallBold.copyWith(
            color: cancelText,
          ),
          text: 'Cancel',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.3,
      maxChildSize: 0.35,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: _buildStatusContent(context),
          ),
        );
      },
    );
  }
}