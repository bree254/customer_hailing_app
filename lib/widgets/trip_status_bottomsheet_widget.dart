import 'dart:ui';

import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/presentation/order_request/controller/trip_status_controller.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_elevated_button.dart';

class TripStatusBottomSheet extends StatelessWidget {
  const TripStatusBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final TripStatusController tripStatusController =
        Get.find<TripStatusController>();

    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.3,
      maxChildSize: 0.6,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.only(top: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(600),
                  ),
                  child: const Divider(
                    height: 20,
                    thickness: 4,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),
                Obx(() {
                  switch (tripStatusController.tripStatus.value) {
                    case TripStatus.onTheWay:
                      return _buildOnTheWayContent();
                    case TripStatus.arrived:
                      return _buildArrivedContent();
                    case TripStatus.headingToDestination:
                      return _buildHeadingToDestinationContent();
                    default:
                      return const SizedBox();
                  }
                }),
                const ListTile(
                    leading: Icon(
                      Icons.circle_outlined,
                      size: 12,
                      color: primaryColor,
                    ),
                    title: Text(
                      'GPO Stage, Kenyatta Avenue',
                      style: TextStyle(
                        color: formTextLabelColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                const ListTile(
                  leading: Icon(
                    Icons.add_circle_outlined,
                    size: 14,
                    color: primaryColor,
                  ),
                  title: Text(
                    'Add stop over',
                    style: TextStyle(
                      color: disabledText,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.location_on,
                    size: 14,
                    color: primaryColor,
                  ),
                  title: const Text(
                    'Mövenpick Residences Nairobi',
                    style: TextStyle(
                      color: formTextLabelColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Text(
                    'Change ',
                    style: TextStyle(
                      color: trailertext,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    // Handle destination change
                  },
                ),
                ListTile(
                  leading: Image.asset(
                      width: 21, height: 22, "assets/images/cash.png"),
                  title: const Text(
                    'Total cost',
                    style: TextStyle(
                      color: Color(0xFF434343),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Text(
                    'Ksh 450',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: formTextLabelColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: CustomElevatedButton(
                    onPressed: () {},
                    buttonStyle: ElevatedButton.styleFrom(
                      backgroundColor: cancelButton,
                      elevation: 0,
                    ),
                    buttonTextStyle: const TextStyle(
                        color: cancelText,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    text: 'Cancel trip',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOnTheWayContent() {
    return Column(
      children: [
        const Center(
          child: Text(
            'Your driver is on the way!',
            style: TextStyle(
              color: primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 32),
        _buildDriverInfo(),
      ],
    );
  }

  Widget _buildArrivedContent() {
    return Column(
      children: [
        const Center(
          child: Text(
            'Your driver has arrived!',
            style: TextStyle(
              color: primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 32),
        _buildDriverInfo(),
      ],
    );
  }

  Widget _buildHeadingToDestinationContent() {
    return Column(
      children: [
        const Center(
          child: Text(
            'Heading to your destination!',
            style: TextStyle(
              color: primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 32),
        _buildDriverInfo(),
      ],
    );
  }

  Widget _buildDriverInfo() {
    final bool isHeadingToDestination =
        Get.find<TripStatusController>().tripStatus.value ==
            TripStatus.headingToDestination;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Stack(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image(
                  image: AssetImage("assets/images/driver.png"),
                  fit: BoxFit.cover,
                  width: 45,
                  height: 45,
                ),
              ),
              Positioned(
                top: 29,
                left: 5,
                child: Container(
                  width: 34,
                  height: 18,
                  padding: const EdgeInsets.all(4),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAFAFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/star.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const Text(
                        '4.85',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF7B7B7B),
                          fontSize: 6,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          title: const Text(
            'James Smith',
            style: TextStyle(
              color: Color(0xFF434343),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'White, Mazda Demio',
                style: TextStyle(
                  color: Color(0xFF434343),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'KCZ 123A',
                style: TextStyle(
                  color: Color(0xFF7145D6),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                  width: 60,
                  height: 30,
                  image: AssetImage("assets/images/mazda.png")),
              if (isHeadingToDestination)
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.shareTrip);
                  },
                  child: const Text(
                    'Share ride details',
                    style: TextStyle(
                      color: Color(0xFF0000F9),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        _buildButtons(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: selectRideColor,
            elevation: 0,
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              children: [
                Icon(
                  Icons.message,
                  size: 16,
                ),
                SizedBox(
                  width: 17,
                ),
                Text(
                  'Message',
                  style: TextStyle(
                    color: Color(0xFF7145D6),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: Colors.white,
                context: Get.context!,
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
                    width: double.infinity,
                    height: 280,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
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
                          alignment:Alignment.topRight,
                          child: GestureDetector(
                            onTap:(){
                              Get.back();
                            },
                            child: Icon(Icons.close),
                          ),
                        ),
                        Text(
                          'Contact options',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF7145D6),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Carrier rates may apply',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF9D9D9D),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        CustomElevatedButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.outgoingCalls);
                          },
                          text: 'In-app call',
                          buttonStyle: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            elevation: 0,
                          ),
                          buttonTextStyle: const TextStyle(
                            color: whiteTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        CustomElevatedButton(
                          onPressed: () {},
                          text: 'Phone call',
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
                  );
                });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: selectRideColor,
            elevation: 0,
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              children: [
                Icon(
                  Icons.phone,
                  size: 16,
                ),
                SizedBox(
                  width: 17,
                ),
                Text(
                  'Call driver',
                  style: TextStyle(
                    color: Color(0xFF7145D6),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
