import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/call_controller.dart';

class OngoingCallScreen extends StatelessWidget {
  final CallController callController = Get.find<CallController>();

   OngoingCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(48,120,48,50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Ongoing call',
              style: TextStyle(
                color: Color(0xFF9D9D9D),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 24),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 50,
              backgroundImage: AssetImage(callController.callerImageUrl.value),
            ),
            const SizedBox(height: 32),
            Obx(() => Text(
              callController.callerName.value,
              style: const TextStyle(
                color: Color(0xFF434343),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )),
            const SizedBox(height: 8),
            Obx(() => Text(
              callController.callDuration.value,
              style: const TextStyle(
                color: Color(0xFF9D9D9D),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            )),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    IconButton(
                        onPressed: (){},
                        icon: const Icon(
                            Icons.volume_up_outlined,
                          size: 24,
                        )
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      'Speaker',
                      style: TextStyle(
                        color: Color(0xFF9D9D9D),
                        fontSize: 10,
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
                      'End',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF9D9D9D),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: (){},
                        icon: const Icon(
                            Icons.keyboard_voice_outlined,
                            size: 24,
                        )
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      'Speaker',
                      style: TextStyle(
                        color: Color(0xFF9D9D9D),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}