// import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:sutra/config/files.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   if (kDebugMode) {
//     print("Handling a background message: ${message.messageId}");
//     print("Handling a background message: ${message.category}");
//     print("Handling a background message: ${message.contentAvailable}");
//     print("Handling a background message: ${message.data}");
//     print("Handling a background message: ${message.from}");
//     print("Handling a background message: ${message.notification}");
//   }
//   AndroidNotificationChannel channel = const AndroidNotificationChannel(
//     'channel-01', // id
//     'Channel Name', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.max,
//     enableVibration: true,
//     showBadge: true,
//   );

//   try {
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!
//         .requestPermission();
//   } catch (e) {
//     log(e.toString());
//   }

//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//   // RemoteNotification? notification = message.notification;
//   // AndroidNotification? android = message.notification?.android;

//   if (message.data.isNotEmpty) {
//     var title = message.data["notification_type"] == "new_loading_instruction"
//         ? "Loading Instruction"
//         : message.data["notification_type"] == "new_booking"
//             ? "New Booking"
//             : message.data["notification_type"] == "new_payment"
//                 ? "Payment Added"
//                 : message.data["notification_type"] == "delivery_order_status"
//                     ? "DO ${message.data["status"]}"
//                     : message.data["notification_type"] == "custom_notification"
//                         ? "${message.data["heading"]}"
//                         : message.data["notification_type"] == "quality_check"
//                             ? "Quality check ${message.data["status"]} - ${message.data["vehicle"]}"
//                             : message.data["notification_type"]
//                                 .toString()
//                                 .replaceAll("_", " ")
//                                 .capitalizeFirst;

//     var subTitle = message.data["notification_type"] ==
//             "new_loading_instruction"
//         ? message.data["trader_name"]
//         : message.data["notification_type"] == "new_booking"
//             ? message.data["trader_name"] +
//                 "-" +
//                 message.data["qty"] +
//                 " " +
//                 message.data["unit"]
//             : message.data["notification_type"] == "new_payment"
//                 ? message.data["trader_name"]
//                 : message.data["notification_type"] == "delivery_order_status"
//                     ? message.data["vehicle"] + " " + message.data["status"]
//                     : message.data["notification_type"] == "custom_notification"
//                         ? message.data["content1"]
//                         : message.data["notification_type"] == "quality_check"
//                             ? dateFormat().format(
//                                 DateTime.parse(message.data["date"]).toLocal())
//                             : "";

//     var payload = message.data["notification_type"] == "new_loading_instruction"
//         ? message.data["vehicle"] +
//             " " +
//             dateFormat().format(DateTime.parse(message.data["date"]).toLocal())
//         : message.data["notification_type"] == "new_booking"
//             ? dateFormat()
//                 .format(DateTime.parse(message.data["date"]).toLocal())
//             : message.data["notification_type"] == "new_payment"
//                 ? "₹  ${message.data["amount"]} rs of ${message.data["type"]}"
//                 : message.data["notification_type"] == "delivery_order_status"
//                     ? dateFormat()
//                         .format(DateTime.parse(message.data["date"]).toLocal())
//                     : message.data["notification_type"] == "custom_notification"
//                         ? message.data["content2"]
//                         : message.data["notification_type"] == "quality_check"
//                             ? message.data["trader_name"] +
//                                 " - " +
//                                 message.data["qty"] +
//                                 "" +
//                                 message.data["unit"]
//                             : "";

//     noti(
//         flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
//         title: title,
//         subTitle: "$subTitle\n$payload",
//         channel: channel);
//   }
// }

// noti({
//   flutterLocalNotificationsPlugin,
//   title,
//   subTitle,
//   channel,
// }) async {
//   await flutterLocalNotificationsPlugin
//       .show(
//           1,
//           title,
//           subTitle,
//           NotificationDetails(
//             android: AndroidNotificationDetails(channel.id, channel.name,
//                 channelDescription: channel.description,
//                 icon: "@mipmap/ic_launcher"),
//           ))
//       .catchError((s) {
//     log("Notification Error :-  $s");
//   });
// }

// Future<void> notification() async {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
  
//   await messaging.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     _firebaseMessagingBackgroundHandler(message);
//   });
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     log("onMessageOpenedApp ---- ${message.toMap()}");
//     log("onMessageOpenedApp Data---- ${message.data}");
//     if (message.data['notification_type'] == 'new_payment') {
//       Get.to(() => const DashboardScreen(pageIndex: 2));
//     }
//     if (message.data['notification_type'] == 'new_booking') {
//       TenderController tenderController = Get.put(TenderController());
//       Get.to(() => TenderDetailsScreen(
//           controller: tenderController, tenderID: message.data["tender_id"]));
//     }
//     if (message.data['notification_type'] == 'new_loading_instruction') {
//       Get.to(() => const DashboardScreen(pageIndex: 3));
//     }
//     if (message.data['notification_type'] == 'delivery_order_status') {
//       Get.to(() => const DashboardScreen(pageIndex: 3));
//     }
//   });

//   if (kDebugMode) {
//     print('User granted permission: ${settings.authorizationStatus}');
//   }
// }
