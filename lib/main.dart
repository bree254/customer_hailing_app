import 'dart:developer';
import 'dart:ui';

import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:customer_hailing/services/notifications_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';

import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await NotificationService.setupFlutterNotifications();
  NotificationService.createLocalNotification(
      dimissable: false, message: message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  log('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);



  // Request location permissions if needed
  await Permission.locationWhenInUse.isDenied.then((valueOfPermission) {
    if (valueOfPermission) {
      Permission.locationWhenInUse.request();
    }
  });

  Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
    PrefUtils().init(),
  ]).then((value) async {
    await dotenv.load();
    runApp( Hailing());
  });
}

class Hailing extends StatelessWidget {
   Hailing({super.key});

   static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

   FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    NotificationService.setUpNotificationService(context);
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        builder: EasyLoading.init(),
        title: 'Taxi App',
        debugShowCheckedModeBanner: false,
        theme: theme,
        navigatorObservers: [observer],
        initialBinding: InitialBindings(),
        initialRoute: AppRoutes.splash,
        getPages: AppRoutes.pages,
      );
    });
  }
}
