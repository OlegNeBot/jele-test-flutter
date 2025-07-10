import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jele_test_flutter/features/messaging/pages/messaging_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // Requesting permissions to use the messaging.
  FirebaseMessaging.instance.requestPermission();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) =>
      const MaterialApp(home: Scaffold(body: MessagingPage()));
}
