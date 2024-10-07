import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../widgets/custom_stepper.dart';
class HistoryDetailsScreen extends StatefulWidget {
  const HistoryDetailsScreen({super.key});

  @override
  State<HistoryDetailsScreen> createState() => _HistoryDetailsScreenState();
}

class _HistoryDetailsScreenState extends State<HistoryDetailsScreen> {
  late final _ratingController;
  late double _rating;

  final double _userRating = 3.0;
  final int _ratingBarMode = 1;
  final double _initialRating = 2.0;
  final bool _isRTLMode = false;
  final bool _isVertical = false;

  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'History',
          style: TextStyle(
            color: Color(0xFF767676),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
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
                    const Center(
                      child: Text(
                        '5th, August, 2024',
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
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/images/driver.png'),
                      ),
                      title: const Text(
                        'Your trip with',
                        style: TextStyle(
                          color: Color(0xFF434343),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle:const Text(
                        'James Smith',
                        style: TextStyle(
                          color: Color(0xFF434343),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: RatingBarIndicator(
                        rating: _userRating,
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
                          title: 'GPO Stage, Kenyatta Avenue',
                          subtitle: '12:00 pm',
                        ),
                        CustomStep(
                          title: 'Mövenpick Residences Nairobi',
                          subtitle:'12:00 pm',
                        ),
                      ],
                      activeStep: 1, // You can adjust this based on your logic
                    ),
                    const SizedBox(height: 32),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                    ),
                    const ListTile(
                        title: Text(
                          'Normal fare',
                          style: TextStyle(
                            color: Color(0xFF767676),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        trailing:Text(
                          'KES 260.00',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF767676),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                    ),

                    const ListTile(
                        title: Text(
                          'Surge ',
                          style: TextStyle(
                            color: Color(0xFF767676),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing:Text(
                          'KES 30.00',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF767676),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    ),

                    const ListTile(
                        title: Text(
                          'Tip',
                          style: TextStyle(
                            color: Color(0xFF767676),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Text(
                          'KES 250.00',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF767676),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                    ),

                    const ListTile(
                        title: Text(
                          'Payment method',
                          style: TextStyle(
                            color: Color(0xFF767676),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Text(
                          'Cash',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF767676),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                    ),
                    const SizedBox(height: 32,),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                    ),
                    const ListTile(
                        title: Text(
                          'Estimated cost',
                          style: TextStyle(
                            color: Color(0xFF555555),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Text(
                          'KES 460',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF555555),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                    ),
                    const SizedBox(height: 32,),
                    CustomElevatedButton(
                      onPressed: (){
                        Get.back();
                      },
                      text: 'Rebook',
                      buttonStyle: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        elevation: 0,
                      ),
                      buttonTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CustomElevatedButton(
                        onPressed: (){
                          Get.back();
                        },
                        text: 'Download Receipt',
                        buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side: const BorderSide(color: primaryColor),
                          elevation: 0,
                        ),
                        buttonTextStyle: const TextStyle(
                          color: primaryColor,
                          fontSize: 12,
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
