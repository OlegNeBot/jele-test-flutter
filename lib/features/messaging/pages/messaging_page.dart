import 'package:flutter/material.dart';
import 'package:jele_test_flutter/common/services/fb_messaging_service.dart';

class MessagingPage extends StatefulWidget {
  const MessagingPage({super.key});

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  late final FbMessagingService _messagingService;

  String? _deviceToken;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _isLoading = true;
    });

    _messagingService = FbMessagingService();

    _messagingService.getToken().then(
      (value) => setState(() {
        _deviceToken = value;
      }),
    );

    _messagingService.init().then(
      (_) => setState(() {
        _isLoading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(10),
    child: Center(
      child:
          _isLoading
              ? const CircularProgressIndicator()
              : Text('Token:\n$_deviceToken'),
    ),
  );
}
