import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/presentation/order_request/controller/trip_status_controller.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../presentation/auth/controller/auth_controller.dart';
import '../presentation/order_request/controller/ride_service_controller.dart';
import '../presentation/order_request/screens/rate_ride_screen.dart';
import '../presentation/order_request/screens/trip_summary_screen.dart';
import 'custom_elevated_button.dart';
import 'package:url_launcher/url_launcher.dart';

class TripStatusBottomSheet extends StatelessWidget {
   TripStatusBottomSheet({super.key});
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    final RideServiceController rideServiceController = Get.find<RideServiceController>();

    final RxBool hasNavigatedToSummary = false.obs;

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
                  final status = rideServiceController.tripDetails.value.tripStatus;

                  switch (status) {
                    case 'ACCEPTED':
                      return _buildOnTheWayContent(rideServiceController);
                    case 'DRIVER_ARRIVED':
                      return _buildArrivedContent(rideServiceController);
                    case 'IN_PROGRESS':
                      return _buildHeadingToDestinationContent(rideServiceController);
                    case 'COMPLETED':
                      if (!hasNavigatedToSummary.value) {
                        hasNavigatedToSummary.value = true;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Get.to(() => const TripSummaryScreen())!.then((_) {
                            Get.to(() => const RateRideScreen());
                          });
                        });
                      }
                      return const SizedBox();
                    default:
                      return const SizedBox();
                  }
                }),
                ListTile(
                  leading: Icon(
                    Icons.circle_outlined,
                    size: 12,
                    color: primaryColor,
                  ),
                  title: Text(
                    rideServiceController.tripDetails.value.tripDetails!.pickupLocation!.address.toString(),
                    style: AppTextStyles.bodySmallPrimary.copyWith(
                      color: formTextLabelColor,
                    ),
                  ),
                ),
                ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.search);
                    },
                    child: Icon(
                      Icons.add_circle_outlined,
                      size: 14,
                      color: primaryColor,
                    ),
                  ),
                  title: Text(
                    'Add stop over',
                    style: AppTextStyles.bodySmallPrimary.copyWith(
                      color: disabledText,
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
                  title: Text(
                    rideServiceController.tripDetails.value.tripDetails!.dropOffLocation!.address.toString(),
                    style: AppTextStyles.bodySmallPrimary.copyWith(
                      color: formTextLabelColor,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.search);
                    },
                    child: Text(
                      'Change ',
                      style: AppTextStyles.text14Black400.copyWith(
                        color: trailertext,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  onTap: () {
                    // Handle destination change
                  },
                ),
                ListTile(
                  leading: Image.asset(
                      width: 21, height: 22, "assets/images/cash.png"),
                  title: Text(
                    'Total Cost',
                    style: const TextStyle(
                      color: Color(0xFF434343),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Text(
                    rideServiceController.tripDetails.value.tripDetails!.estimatedFare.toString(),
                    textAlign: TextAlign.right,
                    style: AppTextStyles.text14Black600.copyWith(
                      color: formTextLabelColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: CustomElevatedButton(
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
                                       Get.toNamed(AppRoutes.cancelationScreen);
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
                                        // Get.back();
                                      },
                                      buttonStyle: ElevatedButton.styleFrom(
                                        backgroundColor: countryTextFieldColor,
                                        elevation: 0,
                                      ),
                                      buttonTextStyle: AppTextStyles.bodySmallBold.copyWith(
                                        color: resendCodeTextColor,
                                      ),
                                      text: 'Back',
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
                    buttonTextStyle: AppTextStyles.backButtonText.copyWith(
                      color: cancelText,
                      fontWeight: FontWeight.w500,
                    ),
                    text: 'Cancel trip',
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOnTheWayContent(RideServiceController rideServiceController) {
    return Column(
      children: [
        Center(
          child: Text(
            'Your driver is on the way!',
            style: AppTextStyles.bodyHeading.copyWith(
              color: primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 32),
        _buildDriverInfo(rideServiceController),
      ],
    );
  }

  Widget _buildArrivedContent(RideServiceController rideServiceController) {
    return Column(
      children: [
        Center(
          child: Text(
            'Your driver has arrived!',
            style: AppTextStyles.bodyHeading.copyWith(
              color: primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 32),
        _buildDriverInfo(rideServiceController),
      ],
    );
  }

  Widget _buildHeadingToDestinationContent(RideServiceController rideServiceController) {
    return Column(
      children: [
        Center(
          child: Text(
            'Heading to your destination!',
            style: AppTextStyles.bodyHeading.copyWith(
              color: primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 32),
        _buildDriverInfo(rideServiceController),
      ],
    );
  }

  Widget _buildDriverInfo(RideServiceController rideServiceController) {
    final bool isHeadingToDestination = rideServiceController.tripDetails.value.tripStatus == 'IN_PROGRESS';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image(
                  image: NetworkImage(rideServiceController.tripDetails.value.driver?.profileUrl ?? ''),
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
                      Text(
                        rideServiceController.tripDetails.value.driver!.rating.toString(),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: resendCodeTextColor,
                          fontSize: 6.0,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          title: Text(
            '${ rideServiceController.tripDetails.value.driver!.firstName.toString()} ${ rideServiceController.tripDetails.value.driver!.lastName.toString()}',
            style: TextStyle(
              color: Color(0xFF434343),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rideServiceController.tripDetails.value.driver!.makeAndModel.toString(),
                style: AppTextStyles.bodySmall.copyWith(
                  color: formTextLabelColor,
                ),
              ),
              Text(
                rideServiceController.tripDetails.value.driver?.numberPlate ?? 'KCZ 123A' ,
                style: AppTextStyles.bodySmall.copyWith(
                  color: primaryColor,
                  fontSize: 10.0,
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
                image: AssetImage("assets/images/mazda.png"),
              ),
              if (isHeadingToDestination)
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.shareTrip);
                  },
                  child: Text(
                    'Share ride details',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: shareTripColor,
                      fontSize: 10.0,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        _buildButtons(rideServiceController),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildButtons(RideServiceController rideServiceController) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () async {
           // Get.toNamed(AppRoutes.messageDriver);
            final phoneNumber = rideServiceController.tripDetails.value.driver!.phoneNumber;
            final url = 'sms:$phoneNumber';
            if (await canLaunch(url)) {
            await launch(url);
            } else {
            throw 'Could not launch $url';
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: selectRideColor,
            elevation: 0,
          ),
          child: Padding(
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
                  style: AppTextStyles.bodySmallPrimary.copyWith(
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
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
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
                        'Contact options',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySmallPrimary.copyWith(
                        ),
                      ),
                      const Text(
                        'Carrier rates may apply',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF9D9D9D),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
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
                        buttonTextStyle: AppTextStyles.bodySmallBold.copyWith(
                          color: whiteTextColor,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomElevatedButton(
                        onPressed: () async {
                          final phoneNumber = rideServiceController.tripDetails.value.driver!.phoneNumber;
                          final url = 'tel:$phoneNumber';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        text: 'Phone call',
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
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: selectRideColor,
            elevation: 0,
          ),
          child: Padding(
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
                  style: AppTextStyles.bodySmallPrimary.copyWith(
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