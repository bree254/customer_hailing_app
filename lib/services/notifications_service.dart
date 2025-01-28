import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../core/utils/pref_utils.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  static String orderNotificationType = "trip_status";
  static const String notificationChannelKey = "yasil_hailing";

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> setUpNotificationService(
      BuildContext buildContext) async {
    await Firebase.initializeApp();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request notification permissions explicitly
    if (!(await isLocalNotificationAllowed())) {
      await Permission.notification.request();
    }

    NotificationSettings settings = await messaging.getNotificationSettings();
    await messaging.getToken().then((value) {
      if (Platform.isAndroid && value != null) {
        debugPrint('FCM Token: $value');
        PrefUtils().setFcmToken(value);
      }
    });

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    if (buildContext.mounted) {
      initNotificationListener(buildContext);
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // static AndroidNotificationChannel channel;

  static bool isFlutterLocalNotificationsInitialized = false;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      notificationChannelKey,
      'ride_notification',
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.getNotificationSettings();
    await messaging.getToken().then((value) {
      if (Platform.isAndroid && value != null) {
        debugPrint('FCM Token: $value');
        PrefUtils().setFcmToken(value);
      }
    });

    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  static void initNotificationListener(BuildContext buildContext) {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Handle incoming messages and display notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        onMessageOpenedAppListener(message, buildContext);
      }
    });
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    if (Platform.isAndroid) {
      createLocalNotification(dimissable: true, message: message);
    }
  }

  static void onMessageOpenedAppListener(
    RemoteMessage remoteMessage,
    BuildContext buildContext,
  ) {
    _onTapNotificationScreenNavigateCallback(
      remoteMessage.data['type'] ?? "",
      remoteMessage.data,
    );
  }

  static void _onTapNotificationScreenNavigateCallback(
    String notificationType,
    Map<String, dynamic> data,
  ) {
    if (notificationType == orderNotificationType) {
      // Get.toNamed(AppRoutes.assignedOrders);
    }
  }

  static Future<bool> isLocalNotificationAllowed() async {
    const notificationPermission = Permission.notification;
    final status = await notificationPermission.status;
    return status.isGranted;
  }

  static Future<void> createLocalNotification({
    required bool dimissable,
    required RemoteMessage message,
  }) async {
    String title = "";
    String body = "";
    String type = "";
    String? image;

    if (message.notification != null) {
      title = message.notification?.title ?? "";
      body = message.notification?.body ?? "";
    } else {
      title = message.data["title"] ?? "";
      body = message.data["body"] ?? "";
    }
    type = message.data['type'] ?? "";
    image = message.data['image'];

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      notificationChannelKey,
      'ride_notification',
      channelDescription: 'ride_notification',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: type,
    );
  }
}
