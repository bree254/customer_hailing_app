import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class TripSummaryScreen extends StatefulWidget {
  const TripSummaryScreen({super.key});

  @override
  State<TripSummaryScreen> createState() => _TripSummaryScreenState();
}

class _TripSummaryScreenState extends State<TripSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 100, 24, 24),
        child: Column(
          children: [
            const SizedBox(
              width: 255,
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
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              width: 255,
              child: Text(
                'Thank you for riding, Ariana',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 74,
            ),
            const SizedBox(
              width: 124,
              child: Text(
                'Total',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Text(
              'KES 290',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF7145D6),
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 74,
            ),
            Divider(
              color: Colors.grey[100],
            ),
            const ListTile(
              leading: Text(
                'Distance',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Text(
                'KES 150.00',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const ListTile(
              leading: Text(
                'Time',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Text(
                'KES 150.00',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const ListTile(
              leading: Text(
                'Base fare',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Text(
                'KES 150.00',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Divider(
              color: Colors.grey[100],
            ),
            const ListTile(
              leading: Text(
                'Normal fare',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 0.14,
                  letterSpacing: 0.25,
                ),
              ),
              trailing: Text(
                'KES 150.00',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const ListTile(
              leading: Text(
                'Surge',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Text(
                'KES 150.00',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              leading: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: Get.context!,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 32, horizontal: 32),
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
                              const Text(
                                'Tip your driver',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF7145D6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                             CustomTextFormField(
                               width: 149,
                               labelText: 'Enter your amount',
                               filled: true,
                               fillColor: countryTextFieldColor,
                               autofocus: false,
                               contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
                               borderDecoration: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10.h),
                                 borderSide: const BorderSide(color: Colors.transparent, width: 0),
                               ),
                             ),
                              const SizedBox(
                                height: 32,
                              ),
                              CustomElevatedButton(
                                onPressed: () {
                                },
                                text: 'Continue',
                                buttonStyle: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  elevation: 0,
                                ),
                                buttonTextStyle: const TextStyle(
                                  color: whiteTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: const Text(
                  'Tip',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF767676),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              trailing: const Text(
                'KES 150.00',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Divider(
              color: Colors.grey[100],
            ),
            const ListTile(
              leading: Text(
                'Subtotal',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 0.14,
                  letterSpacing: 0.25,
                ),
              ),
              trailing: Text(
                'KES 150.00',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
