import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen()async {
    await Future.delayed(const Duration(seconds: 3));
    bool isLoggedIn=false;
    if(isLoggedIn){
      Get.offNamed(AppRoutes.home);
    }else{
      Get.offNamed(AppRoutes.loginorsignup);
    }

  }

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Text(
          'Taxi App',
          style: TextStyle(
              color: whiteTextColor,
            fontFamily: 'br_omny_regular',
            fontWeight: FontWeight.w700,
            fontSize: 32
          ),),

      ),

    );
  }
}
