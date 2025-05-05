import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';

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
        title:  Text(
          'Password & Security',
          style: AppTextStyles.largeAppBarText,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 17,
            color: blackTextColor,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Change Password',
                    style:AppTextStyles.listTileTitle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),

                  ),
                  Text(
                    'Last changed on 12/12/2024',
                    style:AppTextStyles.listTileSubtitle.copyWith(
                      color: darkerGrey,
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
            const SizedBox(height: 16,),
            ListTile(
              title:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2 Factor Authentication',
                    style:AppTextStyles.listTileTitle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'On',
                    style:AppTextStyles.listTileSubtitle.copyWith(
                      color: darkerGrey,
                    ),
                  ),
                ],
              ),
              trailing: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Switch(
                  activeColor: primaryColor,
                  activeTrackColor: Colors.grey[300],
                  trackOutlineColor:WidgetStateColor.transparent,
                  inactiveThumbColor: Colors.grey[100],
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
