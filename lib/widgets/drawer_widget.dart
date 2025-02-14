import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';

import '../presentation/auth/controller/auth_controller.dart';
class DrawerWidget extends StatelessWidget {

  final AuthController authController = Get.put(AuthController());

   DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String initials = '${authController.user.value.firstName?[0]}${authController.user.value.lastName?[0]}';
    return  Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 50),
              child: Obx(() {
                if (authController.user.value.id == null) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: 28,
                    child: Text(
                      initials,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //Image.asset("assets/images/driver.png"),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${authController.user.value.firstName} ${authController.user.value.lastName}',
                        style: AppTextStyles.bodySmallBold.copyWith(
                          color: searchtextGrey,
                        ),
                      ),
                      Text(
                        '${authController.user.value.avgRating} rating',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: formTextLabelColor,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: searchtextGrey,
                    size: 14,
                  ),
                  onTap: () {
                    Get.toNamed(AppRoutes.profile);
                  },
                );
              }),
            ),
            ListTile(
              leading: const Icon(Icons.history,size: 20,),
              title:  Text(
                'History',
                style: AppTextStyles.listTileTitle.copyWith(
                  fontSize: 12.0,
                ),
              ),
              onTap: () {
                Get.toNamed(AppRoutes.tripHistory);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined,size: 20,),
              title:  Text(
                'Scheduled Trips',
                style: AppTextStyles.listTileTitle.copyWith(
                  fontSize: 12.0,
                ),
              ),
              onTap: () {
                Get.toNamed(AppRoutes.scheduleTrip);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined,size: 20,),
              title:  Text(
                'Settings',
                style: AppTextStyles.listTileTitle.copyWith(
                  fontSize: 12.0,
                ),
              ),
              onTap: () {
                // Handle settings tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_offer_outlined,size: 20),
              title:  Text(
                'Promotions',
                style: AppTextStyles.listTileTitle.copyWith(
                  fontSize: 12.0,
                ),
              ),
              onTap: () {
                Get.toNamed(AppRoutes.promotions);
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_support_outlined,size: 20),
              title:  Text(
                'Support',
                style: AppTextStyles.listTileTitle.copyWith(
                  fontSize: 12.0,
                ),
              ),
              onTap: () {
                Get.toNamed(AppRoutes.support);
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment,size: 20),
              title:  Text(
                'Payment',
                style: AppTextStyles.listTileTitle.copyWith(
                  fontSize: 12.0,
                ),
              ),
              onTap: () {
                Get.toNamed(AppRoutes.paymentMethods);
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout,size: 20),
              title:  Text(
                'Logout',
                style: AppTextStyles.listTileTitle.copyWith(
                  fontSize: 12.0,
                ),
              ),
              onTap: () {
                Get.find<AuthController>().logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
