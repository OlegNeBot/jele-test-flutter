import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Service that works with a Firebase Clous Messaging.
class FbMessagingService {
  FbMessagingService();

  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
        'fb_channel',
        'Firebase Channel',
        description: 'This channel is used to show Firebase Notifications',
        importance: Importance.max,
        showBadge: false,
      );

  final FirebaseMessaging _fbMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Returns a device token.
  Future<String?> getToken() async {
    final token = await _fbMessaging.getToken();
    print('Token: $token');

    return token;
  }

  /// Initializes the Firebase Messaging.
  Future<void> init() async {
    // Init the notifications channel.
    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_androidChannel);

    // Handling a message that opened an app from a terminated state.
    RemoteMessage? initialMessage = await _fbMessaging.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage, clicked: true);
    }

    // Handling a message when an app is in the foreground.
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handling a message when an app is in the background.
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) => _handleMessage(message, clicked: true),
    );
  }

  /// Handles the incomed message.
  ///
  /// By now, this method just logs the message.
  void _handleMessage(RemoteMessage message, {bool clicked = false}) {
    log('Received a new message!');

    if (clicked) {
      log('Message clicked!');
    }

    log('Message id: ${message.messageId}');
    log('Message data: ${message.data}');

    if (message.notification != null) {
      log('Message notification: ${message.notification}');
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    final androidNotification = message.notification?.android;

    if (notification != null && androidNotification != null) {
      _localNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: "@drawable/ic_launcher",
          ),
        ),
      );
    }
  }
}
