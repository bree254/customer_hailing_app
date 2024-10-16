import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/call_controller.dart';

class OngoingCallScreen extends StatelessWidget {
  final CallController callController = Get.find<CallController>();

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
              style: TextStyle(
                color: Color(0xFF9D9D9D),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 24),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 50,
              backgroundImage: AssetImage(callController.callerImageUrl.value),
            ),
            SizedBox(height: 32),
            Obx(() => Text(
              callController.callerName.value,
              style: TextStyle(
                color: Color(0xFF434343),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )),
            SizedBox(height: 8),
            Obx(() => Text(
              callController.callDuration.value,
              style: TextStyle(
                color: Color(0xFF9D9D9D),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            )),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    IconButton(
                        onPressed: (){},
                        icon: Icon(
                            Icons.volume_up_outlined,
                          size: 24,
                        )
                    ),
                    SizedBox(height: 10,),
                    Text(
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
                      child: Icon(Icons.call_end),
                    ),
                    SizedBox(height: 10,),
                    Text(
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
                        icon: Icon(
                            Icons.keyboard_voice_outlined,
                            size: 24,
                        )
                    ),
                    SizedBox(height: 10,),
                    Text(
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