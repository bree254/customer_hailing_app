import 'dart:async';

import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../data/api/refresh_token_service.dart';
import '../../data/models/auth/user_response.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initializeData();
  }

  // Future<void> initializeData() async {
  //   await Future.delayed(const Duration(seconds: 3));
  //
  //   String? accessToken = await PrefUtils().retrieveToken('access_token');
  //   bool isLoggedIn = false;
  //
  //   if (accessToken != null) {
  //     isLoggedIn = await _isTokenValid(accessToken);
  //   }
  //
  //   UserResponse? userData = PrefUtils().getUserData();
  //
  //   if (isLoggedIn) {
  //     Get.offNamed(AppRoutes.home);
  //   } else {
  //     Get.offNamed(AppRoutes.emailSignOn);
  //   }
  //
  //   // if (isLoggedIn && userData != null) {
  //   //   Get.offNamed(AppRoutes.home);
  //   // } else {
  //   //   Get.offNamed(AppRoutes.emailSignOn);
  //   // }
  // }

  Future<void> initializeData() async {
    String? accessToken = await PrefUtils().retrieveToken('access_token');
    bool isLoggedIn = false;

    if (accessToken != null) {
      isLoggedIn = await _isTokenValid(accessToken);
      if (!isLoggedIn) {
        bool tokensRefreshed = await refreshTokens();
        if (tokensRefreshed) {
          accessToken = await PrefUtils().retrieveToken('access_token');
          isLoggedIn = await _isTokenValid(accessToken!);
        }
      }
    }

    if (isLoggedIn) {
      Timer(const Duration(seconds: 3), () {
        Get.offAllNamed(AppRoutes.home);
      }
      );
    } else {
      Timer(const Duration(seconds: 3), () {
        Get.offAllNamed(AppRoutes.emailSignOn);
      });

    }
  }

  Future<bool> _isTokenValid(String token) async {
    if (token.isNotEmpty) {
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      if (decodedToken.containsKey('exp')) {
        int expiryTimeInSeconds = decodedToken['exp'];
        DateTime expiryDateTime = DateTime.fromMillisecondsSinceEpoch(expiryTimeInSeconds * 1000);
        return expiryDateTime.isAfter(DateTime.now());
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primaryColor,
      body: Center(
          child: Image(
              height: 100,
              width: 100,
              image: AssetImage('assets/images/yasil_customer.png'),
          ),
        ),
    );
  }
}