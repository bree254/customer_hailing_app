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
                title: const Column(
                  children: [
                  Text(
                        'John Doe',
                        style: TextStyle(
                          color: Color(0xFF767676),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                Text(
                      '4.5 rating',
                      style: TextStyle(
                        color: Color(0xFF434343),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
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
              title: const Text(
                'History',
                style: TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                // Handle history tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined,size: 20,),
              title: const Text(
                'Scheduled Trips',
                style: TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Get.toNamed(AppRoutes.scheduleTrip);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined,size: 20,),
              title: const Text(
                'Settings',
                style: TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                // Handle settings tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_offer_outlined,size: 20),
              title: const Text(
                'Promotions',
                style: TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                // Handle promotions tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_support_outlined,size: 20),
              title: const Text(
                'Support',
                style: TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                // Handle support tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment,size: 20),
              title: const Text(
                'Payment',
                style: TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Get.toNamed(AppRoutes.paymentMethods);
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout,size: 20),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
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
