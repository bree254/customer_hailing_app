import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../controllers/call_controller.dart';
import 'ongoing_call_screen.dart';

class IncomingCallScreen extends StatelessWidget {
  final CallController callController = Get.put(CallController());

   IncomingCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 80.v,),
          const Text(
            'Incoming call',
            style: TextStyle(
              color: Color(0xFF9D9D9D),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Positioned(
            top: 100,
            left: 40,
            right: 40,
            child: Stack(
              children: [
                Lottie.asset(
                    "assets/animations/call_animation.json",
                  height: 300
                ),
                Positioned(
                  left: 100,
                  top: 100,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    backgroundImage: AssetImage(callController.callerImageUrl.value),
                  ),
                ),

              ],
            ),
          ),
          Obx(() => Text(
            callController.callerName.value,
            style: const TextStyle(fontSize: 24),
          )),
          const Spacer(),
          Container(
            margin: EdgeInsets.fromLTRB( 32.h,0,32.h,40.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    FloatingActionButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                      backgroundColor: Colors.green,
                      onPressed: () {
                        callController.acceptCall();
                        Get.to(() =>  OngoingCallScreen()); // Navigate to the Ongoing call screen
                      },
                      child: const Icon(Icons.call),
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      'Answer',
                      style: TextStyle(
                        color: Color(0xFF9D9D9D),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    FloatingActionButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                      backgroundColor: Colors.red,
                      onPressed: () {
                        callController.rejectCall();
                      },
                      child: const Icon(Icons.call_end),
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      'Decline',
                      style: TextStyle(
                        color: Color(0xFF9D9D9D),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.v,)
        ],
      ),
    );
  }
}