import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';

class EmergencyServicesScreen extends StatelessWidget {
  const EmergencyServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:  Text(
          'Emergency Services',
          style: AppTextStyles.largeAppBarText,
        ),
        leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(
                Icons.arrow_back_outlined,
            )),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 32),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                      height: 24,
                      width: 24,
                      'assets/images/headphones.png'
                  ),
                const SizedBox(width: 20,),
                const Text(
                      'Taxi hotline',
                      style: TextStyle(
                        color: Color(0xFF555555),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                      onPressed: (){},
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 14,
                      )),
                ],
              )
            ),
            const SizedBox(height: 16,),
            Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                        height: 24,
                        width: 24,
                        'assets/images/bell.png'
                    ),
                    const SizedBox(width: 20,),
                    const Text(
                      'Local Authorities',
                      style: TextStyle(
                        color: Color(0xFF555555),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_outlined,size: 14,)),
                  ],
                )
            ),
          ],
        ),
      ),

    );
  }
}
