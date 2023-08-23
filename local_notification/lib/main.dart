import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    // Initialize the plugin for Android only.
    var initializationSettingsAndroid =
        AndroidInitializationSettings(defaultSound: true, importance: Importance.high, enableVibration: true, enableLights: true);
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification() {
    // Create a notification channel for Android only.
    const AndroidNotificationChannel channel = AndroidNotificationChannel('high_importance_channel', 'High Importance Notifications',
        importance: Importance.high, enableVibration: true, enableLights: true);

    // Create a notification.
    var notification = NotificationDetails(channel: channel, title: 'Local Notification', body: 'This is a local notification.');

    // Show the notification.
    flutterLocalNotificationsPlugin.show(0, notification.title, notification.body, notification);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Local Notification'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: showNotification,
            child: Text('Show Notification'),
          ),
        ),
      ),
    );
  }
}
