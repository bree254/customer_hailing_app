import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/data/repos/ride_service_repository.dart';
import 'package:customer_hailing/presentation/order_request/controller/ride_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyServicesScreen extends StatelessWidget {
  final RideServiceController controller = Get.put(RideServiceController(rideServiceRepository: RideServiceRepository()));
   EmergencyServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:  Text(
          'Emergency Services',
          style: AppTextStyles.largeAppBarText,
        ),
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(
                Icons.arrow_back_outlined,
            )),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 32),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                        height: 24,
                        width: 24,
                        'assets/images/bell.png',
                      color: redColor,
                    ),
                    const SizedBox(width: 20,),
                     Text(
                      'Local Authorities',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: darkerGrey,
                      ),
                    ),
                    const Spacer(),

                    GestureDetector(
                      onTap: () async {
                        const emergencyNumber = 'tel:999';
                        if (await canLaunch(emergencyNumber)) {
                          await launch(emergencyNumber);
                        } else {
                          throw 'Could not launch $emergencyNumber';
                        }
                      },
                      child: Image.asset(
                          height: 20,
                          width: 20,
                          'assets/images/call.png',
                        color: redColor,
                      ),
                    ),

                    Center(
                      child: IconButton(
                          onPressed: () async {
                            await controller.raiseSos();
                            const emergencyNumber = 'tel:999';
                            if (await canLaunch(emergencyNumber)) {
                              await launch(emergencyNumber);
                            } else {
                              throw 'Could not launch $emergencyNumber';
                            }
                          },
                          icon: const Icon(Icons.phone,size: 24,color: redColor,)),
                    ),
                  ],
                )
            ),

            // const SizedBox(height: 16,),
            // Container(
            //     width: double.infinity,
            //     height: 60,
            //     padding: const EdgeInsets.all(16),
            //     decoration: ShapeDecoration(
            //       color: Colors.white,
            //       shape: RoundedRectangleBorder(
            //         side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     child: Row(
            //       children: [
            //         Image.asset(
            //             height: 24,
            //             width: 24,
            //             'assets/images/headphones.png'
            //         ),
            //         const SizedBox(width: 20,),
            //         Text(
            //           'Taxi hotline',
            //           style: AppTextStyles.bodySmall.copyWith(
            //             color: darkerGrey,
            //           ),
            //         ),
            //         const Spacer(),
            //         IconButton(
            //             onPressed: (){},
            //             icon: const Icon(
            //               Icons.arrow_forward_ios_outlined,
            //               size: 14,
            //             )),
            //       ],
            //     )
            // ),

          ],
        ),
      ),

    );
  }
}
