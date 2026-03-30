import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_archive/core/core_exports.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static const String _channelId = '${Constants.appId}_channel_id';
  static const String _channelName = '${Constants.appName} Notifications';
  static const String _channelDescription = '${Constants.appName} notification channel';

  static Future<void> init() async {
    if (Platform.isIOS) {
      await _getApnsToken();
    }
    await _getFCMToken();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings();

    const initSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin);
    await _flutterLocalNotificationsPlugin.initialize(
        settings: initSettings, onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {});

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.max,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> showNotification(RemoteMessage msg) async {
    String title = msg.notification?.title ?? msg.data['title'] ?? Constants.appName;
    String body = msg.notification?.body ?? msg.data['body'] ?? "Bizni kuzatib boring";

    debugPrint('GGQ => $title $body');
    const NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    await _flutterLocalNotificationsPlugin.show(
        id: msg.messageId?.hashCode ?? 1, title: title, body: body, notificationDetails: details, payload: 'Payload');
  }

  static Future<void> _getFCMToken() async {
    String? fcmToken = await _firebaseMessaging.getToken();
    debugPrint("FCM_TOKEN: $fcmToken");
    if (fcmToken != null) {
      await sl.get<PrefManager>().setFCMToken(fcmToken);
    }
  }

  static Future<void> _getApnsToken() async {
    String? apnsToken;
    int retries = 0;
    int maxRetries = 10;

    while (apnsToken == null && retries < maxRetries) {
      apnsToken = await _firebaseMessaging.getAPNSToken();

      if (apnsToken == null) {
        debugPrint('⏳ Waiting for APNS token... (attempt ${retries + 1}/$maxRetries)');
        await Future.delayed(const Duration(seconds: 1));
        retries++;
      } else {
        debugPrint('✅ APNS_TOKEN: $apnsToken');
      }
    }

    if (apnsToken == null) {
      debugPrint('⚠️ APNS token still null after $maxRetries attempts');
      debugPrint('⚠️ But APNs device token was registered, so notifications should still work');
    }
  }

  static Future<void> get deleteFCMToken async {
    await sl.get<PrefManager>().setFCMToken("");
    await _firebaseMessaging.deleteToken();
  }
}
