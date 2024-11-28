import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../auth/controller/auth_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Profile',
          style: AppTextStyles.largeAppBarText,
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
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
                  Text(
                    '${authController.user.value.firstName} ${authController.user.value.lastName}',
                    style: AppTextStyles.text14Black500.copyWith(
                      color: searchtextGrey,
                    ),
                  ),
                  const SizedBox(height: 8,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star,color: primaryColor,size: 10,),
                      SizedBox(width: 5,),
                      Text(
                        '${authController.user.value.ratingAverage} rating',
                        style: AppTextStyles.text14Black400.copyWith(
                          color: searchtextGrey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 32,),
            Container(
              width: 328,
              padding: const EdgeInsets.symmetric(vertical: 8),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: ListTile(
                leading:  Image.asset(
                  width: 24,
                    height: 24,
                    'assets/images/user-circle-outline.png'
                ),
                title:  Text(
                  'Edit Profile',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: listileText,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_outlined,color: searchtextGrey,size: 14,),
                onTap: () {
                  Get.toNamed(AppRoutes.editProfile);
                },
              ),
            ),
            Container(
              width: 328,
              padding: const EdgeInsets.symmetric(vertical: 8),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: ListTile(
                leading:  Image.asset(
                    width: 24,
                    height: 24,
                    'assets/images/shield-outline.png'
                ),
                title:  Text(
                  'Password & Security',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: listileText,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_outlined,color: searchtextGrey,size: 14,),
                onTap: () {
                  Get.toNamed(AppRoutes.passwordSecurity);
                },
              ),
            ),
            Container(
              width: 328,
              padding: const EdgeInsets.symmetric(vertical: 8),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: ListTile(
                leading:  Image.asset(
                    width: 24,
                    height: 24,
                    'assets/images/map-pin-alt-outline.png'
                ),
                title:  Text(
                  'Saved Locations',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: listileText,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_outlined,color: searchtextGrey,size: 14,),
                onTap: () {
                  Get.toNamed(AppRoutes.savedLocation);
                },
              ),
            ),
            Container(
              width: 328,
              padding: const EdgeInsets.symmetric(vertical: 8),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading:  Image.asset(
                    width: 24,
                    height: 24,
                    'assets/images/logout.png'
                ),
                title:  Text(
                  'Logout',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: deleteIcon,
                  ),
                ),
                onTap: () {
                  authController.logout();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
