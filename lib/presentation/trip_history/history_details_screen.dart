import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/data/repos/ride_service_repository.dart';
import 'package:customer_hailing/presentation/order_request/controller/ride_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_stepper.dart';
class HistoryDetailsScreen extends StatefulWidget {
  const HistoryDetailsScreen({super.key});

  @override
  State<HistoryDetailsScreen> createState() => _HistoryDetailsScreenState();
}

class _HistoryDetailsScreenState extends State<HistoryDetailsScreen> {
  final RideServiceController controller = Get.put(RideServiceController(rideServiceRepository: RideServiceRepository()));
  late final ratingController;
  late double rating;

  final double _initialRating = 2.0;
  final bool _isVertical = false;

  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    ratingController = TextEditingController(text: '3.0');
    rating = _initialRating;

    final String tripId = Get.arguments as String;
    print('history details trip id $tripId');
    controller.getTripHistoryDetails(tripId);
  }

  String extractDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String formatDateTime(String dateTime) {
    final DateTime parsedDateTime = DateTime.parse(dateTime);
    final DateFormat formatter = DateFormat('d MMM yyyy - h:mm a');
    return formatter.format(parsedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    if (controller.historyDetails.value.data == null || controller.historyDetails.value.data!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'History',
            style: AppTextStyles.largeAppBarText,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 17,
              color: blackTextColor,
            ),
          ),
        ),
        body: Center(
          child: Text(
            'No trip history details available.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }
    final historyDetails = controller.historyDetails.value.data!.first;
    print('#########history details ######### $historyDetails');
    final String date = extractDate(historyDetails.startTime!);
    final num rating = historyDetails.driver?.rating ?? 0.0;

    String initials = '${controller.historyDetails.value.data!.first.driver!.firstName?[0]}${controller.historyDetails.value.data!.first.driver!.lastName?[0]}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Text(
          'History',
          style: AppTextStyles.largeAppBarText,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 17,
            color: blackTextColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 16),
                child: Column(
                  children: [
                     Center(
                      child:
                      Text(
                        date,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF767676),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Container(
                      width: double.infinity,
                      height: 149,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/images/trip_estimate.png"),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 31,),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: primaryColor,
                        backgroundImage: controller.historyDetails.value.data!.first.driver!.profileUrl != null
                            ? NetworkImage('${controller.historyDetails.value.data!.first.driver!.profileUrl}')
                            : null,
                        child: controller.historyDetails.value.data!.first.driver!.profileUrl == null
                            ? Text(
                          initials,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                            : null,
                      ),
                      title:  Text(
                        'Your trip with',
                        style:AppTextStyles.bodySmall.copyWith(
                          color: formTextLabelColor,
                          fontSize: 10.0,// Color of the title text
                        ),
                      ),
                      subtitle: Text(
                       '${ controller.historyDetails.value.data!.first.driver!.firstName} ${ controller.historyDetails.value.data!.first.driver!.lastName}',
                        //'James Smith',
                        style:AppTextStyles.text14Black600.copyWith(
                          color: formTextLabelColor,

                        ),

                      ),
                      trailing: RatingBarIndicator(
                        rating: rating.toDouble(),
                        //_userRating,
                        itemBuilder: (context, index) => Icon(
                          _selectedIcon ?? Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 15.0,
                        unratedColor: Colors.amber.withAlpha(50),
                        direction: _isVertical ? Axis.vertical : Axis.horizontal,
                      ),
                    ),
                    const SizedBox(height: 32),
                    CustomStepperWidget(
                      steps: [
                        CustomStep(
                          title: controller.historyDetails.value.data!.first.origin!,
                          subtitle: formatDateTime(controller.historyDetails.value.data!.first.startTime!.toString()),
                        ),
                        CustomStep(
                          title: controller.historyDetails.value.data!.first.destination!,
                          subtitle: formatDateTime(controller.historyDetails.value.data!.first.endTime!.toString()),
                        ),
                      ],
                      activeStep: 1, // You can adjust this based on your logic
                    ),
                    const SizedBox(height: 32),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                    ),
                     ListTile(
                        title: Text(
                          'Normal fare',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: searchtextGrey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        trailing:Text(
                          controller.historyDetails.value.data!.first.fare!,
                         // 'KES 260.00',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: searchtextGrey,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                    ),

                    //  ListTile(
                    //     title: Text(
                    //       'Surge ',
                    //       style: AppTextStyles.bodySmall.copyWith(
                    //         color: searchtextGrey,
                    //       ),
                    //     ),
                    //     trailing:Text(
                    //       'KES 30.00',
                    //       textAlign: TextAlign.right,
                    //       style: AppTextStyles.bodySmall.copyWith(
                    //         color: searchtextGrey,
                    //       ),
                    //     ),
                    // ),

                    //  ListTile(
                    //     title: Text(
                    //       'Tip',
                    //       style: AppTextStyles.bodySmall.copyWith(
                    //         color: searchtextGrey,
                    //       ),
                    //     ),
                    //     trailing: Text(
                    //       'KES 250.00',
                    //       textAlign: TextAlign.right,
                    //       style: AppTextStyles.bodySmall.copyWith(
                    //         color: searchtextGrey,
                    //       ),
                    //     )
                    // ),

                     ListTile(
                        title: Text(
                          'Payment method',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: searchtextGrey,
                          ),
                        ),
                        trailing: Text(
                          controller.historyDetails.value.data!.first.paymentMethod!,
                          //'Cash',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: searchtextGrey,
                          ),
                        )
                    ),
                    const SizedBox(height: 32,),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                    ),
                     ListTile(
                        title: Text(
                          'Estimated cost',
                          style: AppTextStyles.text14Black500.copyWith(
                            color: darkerGrey,
                            fontSize: 16.0,
                          ),
                        ),
                        trailing: Text(
                          controller.historyDetails.value.data!.first.fare!,
                          //'KES 460',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.text14Black500.copyWith(
                            color: darkerGrey,
                            fontSize: 16.0,
                          ),
                        )
                    ),
                    const SizedBox(height: 32,),
                    // CustomElevatedButton(
                    //   onPressed: (){
                    //     Navigator.pop(context);
                    //   },
                    //   text: 'Rebook',
                    //   buttonStyle: ElevatedButton.styleFrom(
                    //     backgroundColor: primaryColor,
                    //     elevation: 0,
                    //   ),
                    //   buttonTextStyle: AppTextStyles.bodySmallPrimary.copyWith(
                    //     color: Colors.white,
                    //   ),
                    // ),
                    const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CustomElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        text: 'Download Receipt',
                        buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side: const BorderSide(color: primaryColor),
                          elevation: 0,
                        ),
                        buttonTextStyle: AppTextStyles.bodySmallPrimary.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
