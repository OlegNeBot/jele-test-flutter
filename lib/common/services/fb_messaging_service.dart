import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

/// Service that works with a Firebase Clous Messaging.
class FbMessagingService {
  FbMessagingService();

  final FirebaseMessaging _fbMessaging = FirebaseMessaging.instance;

  /// Returns a device token.
  Future<String?> getToken() => _fbMessaging.getToken();

  /// Initializes the Firebase Messaging.
  Future<void> init() async {
    // Handling a message that opened an app from a terminated state.
    RemoteMessage? initialMessage = await _fbMessaging.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage, clicked: true);
    }

    // Handling a message when an app is in the foreground.
    FirebaseMessaging.onMessage.listen((message) => _handleMessage(message));

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
}
