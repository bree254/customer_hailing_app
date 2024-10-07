import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/order_request/controller/ride_status_controller.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
          'Sit tight as we get the nearest available driver for you!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: resendCodeTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 22),
        CustomElevatedButton(
            onPressed: () {
              Get.back();
            },
            buttonStyle: ElevatedButton.styleFrom(
              backgroundColor: cancelButton,
              elevation: 0,
            ),
            buttonTextStyle: const TextStyle(
                color: cancelText,
                fontSize: 12,
                fontWeight: FontWeight.w500
            ),
            text: 'Cancel',
          ),
      ],
    );
  }

   Widget _buildConnectingContent() {
     return Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         const Center(
           child: Padding(
             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
             child: Text(
               "Connecting you to your driver",
               style: TextStyle(
                 fontSize: 16,
                 color: primaryColor,
                 fontWeight: FontWeight.w600,
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
                 // Left circular avatar placeholder
                 Container(
                   width: 50.0,
                   height: 50.0,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(30.0),
                   ),
                 ),
                 const SizedBox(width: 5,),
                 // Text placeholders
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
                 const SizedBox(width: 5,),
                 // Right circular avatar placeholder
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
         const SizedBox(height: 20,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 0.0),
           child: Shimmer.fromColors(
             baseColor: Colors.grey[300]!,
             highlightColor: Colors.grey[100]!,
             child: Row(
               mainAxisSize: MainAxisSize.min,
               children: [
                 // Left circular avatar placeholder
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
                 const SizedBox(width: 10,),
                 // Right circular avatar placeholder
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
                 )
               ],
             ),
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
        CustomElevatedButton(
            onPressed: () {
              Get.back();
            },
            buttonStyle: ElevatedButton.styleFrom(
              backgroundColor: cancelButton,
              elevation: 0,
            ),
            buttonTextStyle: const TextStyle(
                color: cancelText,
                fontSize: 12,
                fontWeight: FontWeight.w500
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
          padding: const EdgeInsets.fromLTRB(16,16,16,0),
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
