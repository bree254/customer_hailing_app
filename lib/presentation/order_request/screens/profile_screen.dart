import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                            backgroundColor:Colors.transparent,
                            child: Image.asset(
                              width: 56,
                              height: 56,
                              'assets/images/driver.png',
                            ),
                        ),
                        Positioned(
                          left: 28,
                            child: 
                            GestureDetector(
                                child: Image.asset(
                                    width: 15,
                                    height: 15,
                                    "assets/images/pen-outline.png")
                            ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 13,),
                  const Text(
                    'John Doe',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF767676),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star,color: primaryColor,size: 10,),
                      SizedBox(width: 5,),
                      Text(
                        '4.5 rating',
                        style: TextStyle(
                          color: Color(0xFF434343),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 32,),
            ListTile(
              leading:  Image.asset(
                width: 24,
                  height: 24,
                  'assets/images/user-circle-outline.png'
              ),
              title: const Text(
                'Personal Information',
                style: TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined,color: searchtextGrey,size: 14,),
              onTap: () {
                // Handle settings tap
              },
            ),
            ListTile(
              leading:  Image.asset(
                  width: 24,
                  height: 24,
                  'assets/images/shield-outline.png'
              ),
              title: const Text(
                'Security',
                style: TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined,color: searchtextGrey,size: 14,),
              onTap: () {
                // Handle settings tap
              },
            ),
            ListTile(
              leading:  Image.asset(
                  width: 24,
                  height: 24,
                  'assets/images/map-pin-alt-outline.png'
              ),
              title: const Text(
                'Saved Locations',
                style: TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined,color: searchtextGrey,size: 14,),
              onTap: () {
                Get.toNamed(AppRoutes.savedLocation);
              },
            ),
            const Spacer(),
            CustomElevatedButton(
              onPressed: () {
                Get.back();
              },
              buttonStyle: ElevatedButton.styleFrom(
                backgroundColor: cancelButton,
                elevation: 0,
              ),
              buttonTextStyle: const TextStyle(
                color: Color(0xFFC81E1E),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              text: 'Delete Account',
              leftIcon: const Icon(CupertinoIcons.trash,color: deleteIcon,size: 12,),
            ),
          ],
        ),
      ),
    );
  }
}
