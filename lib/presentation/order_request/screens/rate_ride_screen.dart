import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateRideScreen extends StatefulWidget {
  const RateRideScreen({super.key});

  @override
  _RateRideScreenState createState() => _RateRideScreenState();
}

class _RateRideScreenState extends State<RateRideScreen> {
  double _rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16.0,40,16,8),
          child: Column(
            children: [
              const SizedBox(height: 40,),
              const Center(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/driver.png'),
                ),
              ),
              const SizedBox(height: 20),
               Text(
                'Rate your trip with James',
                textAlign: TextAlign.center,
                style: AppTextStyles.onBoardingAppBarText.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 32),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              const SizedBox(height: 32),
               Text(
                'No thanks',
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: NoThanksText,
                ),
              ),
              const Spacer(),
              CustomElevatedButton(
                  text: "Continue",
                onPressed: _rating == 0.0
                  ? null
                  : () {
                      // Handle button press
                    },
                buttonStyle: ElevatedButton.styleFrom(
                  backgroundColor: _rating == 0.0 ? disabledButtonGrey : primaryColor,
                ),
            ),
            ],
          ),

      ),
    );
  }
}
