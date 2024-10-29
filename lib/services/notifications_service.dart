import 'dart:io';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';


class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  static String orderNotificationType = "trip_status";
  static const String notificationChannelKey = "basic_channel";

  static Future<void> setUpNotificationService(BuildContext buildContext) async {
    await Firebase.initializeApp();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request notification permissions explicitly
    if (!(await isLocalNotificationAllowed())) {
      await Permission.notification.request();
    }

    NotificationSettings settings = await messaging.getNotificationSettings();
    // await messaging.getToken().then((value) {
    //   if(Platform.isAndroid)
    //     if (value != null) {
    //       PrefUtils().setFcmToken(value);
    //     }
    // });

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
  }

  static void initNotificationListener(BuildContext buildContext) {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationService.onActionReceivedMethod,
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Handle incoming messages and display notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        onMessageOpenedAppListener(message, buildContext);

      }
    });
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction,
      ) async {
    if (Platform.isAndroid) {
      _onTapNotificationScreenNavigateCallback(
        (receivedAction.payload ?? {})['type'] ?? "",
        Map.from(receivedAction.payload ?? {}),
      );
    }
  }
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
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

    if (image == null) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: Random().nextInt(5000),
          autoDismissible: dimissable,
          title: title,
          body: body,
          locked: !dimissable,
          wakeUpScreen: true,
          payload: {"type": type},
          channelKey: notificationChannelKey,
          notificationLayout: NotificationLayout.BigText,
        ),
      );
    } else {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: Random().nextInt(5000),
          autoDismissible: dimissable,
          title: title,
          body: body,
          locked: !dimissable,
          wakeUpScreen: true,
          bigPicture: image,
          payload: {"type": type},
          channelKey: notificationChannelKey,
          notificationLayout: NotificationLayout.BigPicture,
        ),
      );
    }
  }
}