import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_service.dart';
import 'remote_config_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer _timer;
  int _intervalSeconds = 15;
  bool _notificationsEnabled = true;
  String _currentTitle = '';
  String _currentMessage = '';

  @override
  void initState() {
    super.initState();
    _loadNotificationSetting();
    _requestPermission();
    _startLoop();
  }

  Future<void> _loadNotificationSetting() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
    });
  }

  Future<void> _saveNotificationSetting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value);
  }

  Future<void> _requestPermission() async {
    if (Platform.isAndroid && Platform.version.startsWith('13')) {
      await Permission.notification.request();
    }
  }

  void _startLoop() async {
    final config = RemoteConfigService();
    await config.initialize();

    _intervalSeconds = config.notificationInterval;
    _currentTitle = config.notificationTitle;
    _currentMessage = config.notificationMessage;

    _timer = Timer.periodic(Duration(seconds: _intervalSeconds), (timer) {
      if (_notificationsEnabled) {
        NotificationService.showNotification(
          title: _currentTitle,
          message: _currentMessage,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firebase Notifier")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Notify every $_intervalSeconds seconds"),
            const SizedBox(height: 12),
            Text("Title: $_currentTitle"),
            Text("Message: $_currentMessage"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Enable Notifications"),
                Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                    _saveNotificationSetting(value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
