// import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

// class NotificationPermissions {
//   final FirebaseMessaging messaging = FirebaseMessaging.instance;

//   Future<void> requestNotificationPermission() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       log('✅ User granted notification permission');

//       // ✅ Get token after permission
//       String? token = await messaging.getToken();
//       log('✅ FCM Token: $token');

//       Get.snackbar("Notification", "Permission granted");
//     } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//       log('🟡 User granted provisional permission');
//       Get.snackbar("Notification", "Provisional permission granted");
//     } else {
//       log('❌ User declined notification permission');
//       Get.snackbar("Notification", "Permission denied");
//     }
//   }

//   Future<bool> isNotificationPermissionGranted() async {
//     return Permission.notification.isGranted;
//   }

//   Future<String?> getDeviceToken() async {
//     try {
//       String? token = await messaging.getToken();
//       log("✅ FCM Token: $token");
//       return token;
//     } catch (e) {
//       log("❌ Error getting device token: $e");
//       return null;
//     }
//   }
// }
