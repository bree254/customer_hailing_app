import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/splash/splash_screen.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
    PrefUtils().init(),
  ]).then((value) async {
  runApp(const Hailing());
  });
}

class Hailing extends StatelessWidget {
  const Hailing({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Taxi App',
        debugShowCheckedModeBanner: false,
        theme: theme,
        initialBinding: InitialBindings(),
        initialRoute: AppRoutes.home,
        getPages: AppRoutes.pages,
        home: const SplashScreen(),
      );
    });
  }
}
