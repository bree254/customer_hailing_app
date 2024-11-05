import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_text_styles.dart';
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
             Text(
              'Ongoing call',
              style: AppTextStyles.bodyRegular,
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
              style: AppTextStyles.bodyLarge,
            )),
            const SizedBox(height: 8),
            Obx(() => Text(
              callController.callDuration.value,
              style: AppTextStyles.bodySmall,
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
                     Text(
                      'Speaker',
                      style: AppTextStyles.bodyRegular.copyWith(fontSize: 12.0,),
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
                     Text(
                      'End',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodySmall,
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
                     Text(
                      'Speaker',
                      style: AppTextStyles.bodySmall.copyWith(fontSize: 12.0,),
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