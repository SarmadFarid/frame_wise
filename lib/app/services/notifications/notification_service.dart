// import 'dart:developer';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:get/get.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// import 'notification_permissions.dart';

// class NotificationService {
//   static final FirebaseMessaging _firebaseMessaging =
//       FirebaseMessaging.instance;

//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   static bool _isInitialized = false;

//   /// ✅ Call this from main() after Firebase.initializeApp()
//   static Future<void> initialize() async {
//     if (_isInitialized) return;
//     _isInitialized = true;

//     // ✅ REQUIRED FOR TIMEZONE SUPPORT
//     tz.initializeTimeZones();
//     final String timeZoneName = await FlutterTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZoneName));

//     // ✅ Initialize Local Notifications
//     const AndroidInitializationSettings androidInitSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initSettings =
//         InitializationSettings(android: androidInitSettings);

//     await _flutterLocalNotificationsPlugin.initialize(
//       initSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         log("📌 Local notification clicked: ${response.payload}");
//       },
//     );

//     // ✅ Request Notification Permission
//     await NotificationPermissions().requestNotificationPermission();

//     // ✅ Foreground Listener
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       log("📩 Foreground Message: ${message.notification?.title}");
//       showNotification(message);
//     });

//     // ✅ When app opened from notification
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       log("📌 Push notification clicked: ${message.notification?.title}");
//     });

//     // ✅ Optional: print token
//     final token = await _firebaseMessaging.getToken();
//     log("✅ FCM Token: $token");
//   }

//   /// ✅ IMPORTANT:
//   /// Background handler MUST be top-level in real apps.
//   /// This is kept here because generator writes files only.
//   static Future<void> firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     log("📩 Background Message: ${message.notification?.title}");
//   }

//   // ✅ Show Notification
//   static Future<void> showNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'layerx_channel',
//       'LayerX Notifications',
//       channelDescription: 'LayerX push notifications channel',
//       importance: Importance.high,
//       priority: Priority.high,
//       playSound: true,
//     );

//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidDetails);

//     await _flutterLocalNotificationsPlugin.show(
//       message.hashCode,
//       message.notification?.title ?? "No Title",
//       message.notification?.body ?? "No Body",
//       notificationDetails,
//       payload: message.data.isNotEmpty ? message.data.toString() : null,
//     );
//   }

//   // ✅ Schedule Notification
//   static Future<void> scheduleNotification({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime scheduledDate,
//   }) async {
//     await _flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.from(scheduledDate, tz.local),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'layerx_channel',
//           'LayerX Notifications',
//           channelDescription: 'LayerX push notifications channel',
//           importance: Importance.high,
//           priority: Priority.high,
//         ),
//       ),
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }
// }
