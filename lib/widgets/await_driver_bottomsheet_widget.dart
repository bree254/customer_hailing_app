import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/presentation/order_request/controller/ride_status_controller.dart';
import 'package:flutter/material.dart';
class AwaitDriverBottomsheetWidget extends StatelessWidget {
   AwaitDriverBottomsheetWidget({super.key});

  final RideStatusController rideStatusController = Get.find<RideStatusController>();

  Widget _buildStatusContent() {
    return Obx(() {
      switch (rideStatusController.currentStatus.value) {
        case RideStatus.searching:
          return _buildSearchingContent();
        case RideStatus.connecting:
          return _buildConnectingContent();
        case RideStatus.lookingForAnother:
          return _buildLookingForAnotherContent();
        default:
          return Container();
      }
    });
  }

  Widget _buildSearchingContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 60.0),
          child: LinearProgressIndicator(minHeight:4,borderRadius: BorderRadius.circular(20),),
        )),
        const SizedBox(height: 14),
        const Text("Searching for nearby drivers",  style: TextStyle(
            fontSize: 16,
            color: primaryColor,
            fontWeight: FontWeight.w600
        ),),
        const SizedBox(height: 14),
        const Text(
          'Sit tight as we get the nearest available \ndriver for you!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: resendCodeTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 22),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: CustomElevatedButton(
            onPressed: () {
              // Handle cancel
              // Get.toNamed(AppRoutes.tripStatus);
            },
            buttonStyle: ElevatedButton.styleFrom(
              backgroundColor: cancelButton,
            ),
            buttonTextStyle: const TextStyle(
                color: cancelText,
                fontSize: 12,
                fontWeight: FontWeight.w500
            ),
            text: 'Cancel',
          ),
        ),
      ],
    );
  }

  Widget _buildConnectingContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 60.0),
          child: LinearProgressIndicator(minHeight:4,borderRadius: BorderRadius.circular(20),),
        )),
        const SizedBox(height: 14),
        const Center(
          child: Text(
            "Connecting you to your driver",
            style: TextStyle(
                fontSize: 16,
                color: primaryColor,
                fontWeight: FontWeight.w600
            ),),
        ),
        const SizedBox(height: 14),
        const CircularProgressIndicator(),
        const SizedBox(height: 22),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: CustomElevatedButton(
            onPressed: () {
              // Handle cancel
            },
            buttonStyle: ElevatedButton.styleFrom(
              backgroundColor: cancelButton,
            ),
            buttonTextStyle: const TextStyle(
                color: cancelText,
                fontSize: 12,
                fontWeight: FontWeight.w500
            ),
            text: 'Cancel',
          ),
        ),
      ],
    );
  }

  Widget _buildLookingForAnotherContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 60.0),
          child: LinearProgressIndicator(minHeight:4,borderRadius: BorderRadius.circular(20),),
        )),
        const SizedBox(height: 14),
        const Text(
          "Looking for another driver",
          style: TextStyle(
              fontSize: 16,
              color: primaryColor,
              fontWeight: FontWeight.w600
          ),
        ),
        const SizedBox(height: 14),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 0,horizontal:0 ),
          child: Center(
            child: Text(
              "Your previous driver did not confirm your request",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: resendCodeTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        const SizedBox(height: 22),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: CustomElevatedButton(
            onPressed: () {
              // Handle cancel
            },
            buttonStyle: ElevatedButton.styleFrom(
              backgroundColor: cancelButton,
            ),
            buttonTextStyle: const TextStyle(
                color: cancelText,
                fontSize: 12,
                fontWeight: FontWeight.w500
            ),
            text: 'Cancel',
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      minChildSize: 0.35,
      maxChildSize: 0.35,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: _buildStatusContent(),
          ),
        );
      },
    );
  }
}
