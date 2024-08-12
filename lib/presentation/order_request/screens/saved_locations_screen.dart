import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
class SavedLocationsScreen extends StatefulWidget {
  const SavedLocationsScreen({super.key});

  @override
  State<SavedLocationsScreen> createState() => _SavedLocationsScreenState();
}

class _SavedLocationsScreenState extends State<SavedLocationsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Saved Locations',
          style: TextStyle(
            color: Color(0xFF767676),
            fontSize: 16,
            fontFamily: 'BR Omny',
            fontWeight: FontWeight.w600,
            height: 0.08,
            letterSpacing: 0.25,
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
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 36),
              child: Column(
                children: [
                  Container(
                    width: 328,
                    height: 56,
                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                    margin: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
                    decoration: ShapeDecoration(
                      color: Color(0x7FFAFAFA),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.02500000037252903),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                            Icons.home_outlined,
                        ),
                        SizedBox(width: 16,),
                        Text(
                          'Enter Home Location',
                          style: TextStyle(
                            color: Color(0xFF767676),
                            fontSize: 12,
                            fontFamily: 'BR Omny',
                            fontWeight: FontWeight.w400,
                            height: 0.14,
                            letterSpacing: 0.25,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 328,
                    height: 56,
                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                    margin: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
                    decoration: ShapeDecoration(
                      color: Color(0x7FFAFAFA),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.02500000037252903),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.briefcase,
                        ),
                        SizedBox(width: 16,),
                        Text(
                          'Enter Home Location',
                          style: TextStyle(
                            color: Color(0xFF767676),
                            fontSize: 12,
                            fontFamily: 'BR Omny',
                            fontWeight: FontWeight.w400,
                            height: 0.14,
                            letterSpacing: 0.25,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 34,),
                  GestureDetector(
                    onTap:(){
                      Get.toNamed(AppRoutes.searchLocation);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle_outlined, color: primaryColor, size: 14),
                          SizedBox(width: 5),
                          Text(
                            'Add stop over',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 0.14,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],

      ),
      ),
    );
  }
}
