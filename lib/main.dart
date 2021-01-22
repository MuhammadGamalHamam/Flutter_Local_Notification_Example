import 'package:flutter/material.dart';
import 'package:flutterlocalnotifications/local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.yellow[800]),
      debugShowCheckedModeBanner: false,
      home: LocalNotifications
        (title: 'Flutter Local Notification'),
    );
  }
}