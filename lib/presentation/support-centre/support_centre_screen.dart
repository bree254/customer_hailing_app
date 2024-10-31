import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';

class SupportCentreScreen extends StatefulWidget {
  const SupportCentreScreen({super.key});

  @override
  State<SupportCentreScreen> createState() => _SupportCentreScreenState();
}

class _SupportCentreScreenState extends State<SupportCentreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Text(
          'Support centre',
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
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 32),
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.faq);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const ListTile(
                  title: Text(
                    'FAQs',
                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  subtitle: Text(
                    'Get answers to frequent questions',
                    style: TextStyle(
                      color: Color(0xFF434343),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,color: formTextLabelColor,size: 14,),
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.chatList);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const ListTile(
                  title: Text(
                    'Chat',
                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  subtitle: Text(
                    'Start a chat with one of our support staff',
                    style: TextStyle(
                      color: Color(0xFF434343),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,color: formTextLabelColor,size: 14,),
                ),
              ),
            )

          ],

        ),
      ),
    );
  }
}
