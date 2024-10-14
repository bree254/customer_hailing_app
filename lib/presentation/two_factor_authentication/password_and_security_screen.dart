import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../routes/routes.dart';
class PasswordAndSecurityScreen extends StatefulWidget {
  const PasswordAndSecurityScreen({super.key});

  @override
  State<PasswordAndSecurityScreen> createState() => _PasswordAndSecurityScreenState();
}

class _PasswordAndSecurityScreenState extends State<PasswordAndSecurityScreen> {
  bool notificationsEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Password & Security',
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
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Change Password',
                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Last changed on 12/12/2024',
                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              trailing: GestureDetector(
                  onTap:(){
                    // Get.toNamed(AppRoutes.twoFA);
                    Get.toNamed(AppRoutes.changePassword);
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 14,
                  )),
            ),
            SizedBox(height: 16,),
            ListTile(
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2 Factor Authentication',
                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'On',
                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              trailing: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Switch(
                  activeColor: primaryColor,
                  activeTrackColor: Colors.grey,
                  trackOutlineColor:WidgetStateColor.transparent,
                  inactiveThumbColor: Colors.grey[200],
                  value: notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
