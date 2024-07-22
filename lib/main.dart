import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/splash/splash_screen.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Hailing());
}

class Hailing extends StatelessWidget {
  const Hailing({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Taxi App',
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBindings(),
        initialRoute: AppRoutes.home,
        getPages: AppRoutes.pages,
        home: SplashScreen(),
      );
    });
  }
}
