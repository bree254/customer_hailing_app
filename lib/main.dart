import 'dart:ui';

import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:customer_hailing/services/notifications_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Request location permissions if needed
  await Permission.locationWhenInUse.isDenied.then((valueOfPermission) {
    if (valueOfPermission) {
      Permission.locationWhenInUse.request();
    }
  });

  await Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
    PrefUtils().init(),
  ]);

  FirebaseMessaging.onBackgroundMessage(NotificationService.firebaseMessagingBackgroundHandler);

  runApp(const Hailing());
}

class Hailing extends StatelessWidget {
  const Hailing({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationService.setUpNotificationService(context);
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Taxi App',
        debugShowCheckedModeBanner: false,
        theme: theme,
        initialBinding: InitialBindings(),
        initialRoute: AppRoutes.splash,
        getPages: AppRoutes.pages,
      );
    });
  }
}