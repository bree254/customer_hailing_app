import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 50),
              child: ListTile(
                leading: Image.asset("assets/images/driver.png"),
                title:  Column(
                  children: [
                  Text(
                        'John Doe',
                        style: AppTextStyles.bodySmallBold.copyWith(
                          color: searchtextGrey,
                        ),

                      ),
                Text(
                      '4.5 rating',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: formTextLabelColor,
                        fontSize: 10.0,
                      ),

                    ),

                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios_outlined,color: searchtextGrey,size: 14,),
                onTap: () {
                 Get.toNamed(AppRoutes.profile);
                },
              ),
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
                // Handle logout tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
