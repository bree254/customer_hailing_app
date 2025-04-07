import Flutter
import UIKit
import Firebase // Import Firebase
import GoogleMaps
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  // This is required to make any communication available in the action isolate.
     FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
       GeneratedPluginRegistrant.register(with: registry)
     }

    FirebaseApp.configure() // Initialize Firebase
    GMSServices.provideAPIKey("AIzaSyAFFMad-10qvSw8wZl7KgDp0jVafz4La6E")

    GeneratedPluginRegistrant.register(with: self)
     // Initialize flutter_local_notifications
        if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}