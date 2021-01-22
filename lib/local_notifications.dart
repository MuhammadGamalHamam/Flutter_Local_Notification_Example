import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutterlocalnotifications/destination_screen.dart';

class LocalNotifications extends StatefulWidget {

  String title;

  LocalNotifications({this.title});

  @override
  _LocalNotificationsState createState() => _LocalNotificationsState();
}

class _LocalNotificationsState extends State<LocalNotifications> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    requestPermissions();
    var androidSettings = AndroidInitializationSettings('app_icon');
    var iOSSettings = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    var initSetttings = InitializationSettings(androidSettings, iOSSettings);
    flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: onClickNotification);

  }

  void requestPermissions() {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future onClickNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return DestinationScreen(
        payload: payload,
      );
    }));
  }

  showSimpleNotification() async {
    var androidDetails = AndroidNotificationDetails('id', 'channel ', 'description',
        priority: Priority.High, importance: Importance.Max);
    var iOSDetails = IOSNotificationDetails();
    var platformDetails = new NotificationDetails(androidDetails, iOSDetails);
    await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification', 'Flutter Simple Notification',
        platformDetails, payload: 'Destination Screen (Simple Notification)');
  }

  Future<void> showScheduleNotification() async {
    var scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: 3));
    var androidDetails = AndroidNotificationDetails(
      'channel_id',
      'Channel Name',
      'Channel Description',
      icon: 'app_icon',
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );
    var iOSDetails = IOSNotificationDetails();
    var platformDetails = NotificationDetails(androidDetails, iOSDetails);
    await flutterLocalNotificationsPlugin.schedule(0, 'Flutter Local Notification', 'Flutter Schedule Notification',
        scheduledNotificationDateTime, platformDetails, payload: 'Destination Screen(Schedule Notification)');
  }

  Future<void> showPeriodicNotification() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('channel_id', 'Channel Name', 'Channel Description');
    const NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails, null);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'Flutter Local Notification', 'Flutter Periodic Notification',
        RepeatInterval.EveryMinute, notificationDetails, payload: 'Destination Screen(Periodic Notification)');
  }

  Future<void> showBigPictureNotification() async {
    var bigPictureStyleInformation = BigPictureStyleInformation(
      DrawableResourceAndroidBitmap("cover_image"),
      largeIcon: DrawableResourceAndroidBitmap("app_icon"),
      contentTitle: 'Flutter Big Picture Notification Title',
      summaryText: 'Flutter Big Picture Notification Summary Text',
    );
    var androidDetails = AndroidNotificationDetails(
        'channel_id',
        'Channel Name',
        'Channel Description',
        styleInformation: bigPictureStyleInformation);
    var platformDetails = NotificationDetails(androidDetails, null);
    await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification', 'Flutter Big Picture Notification',
        platformDetails, payload: 'Destination Screen(Big Picture Notification)');
  }



  Future<void> showProgressNotification() async {
    const int maxProgress = 5;
    for (int i = 0; i <= maxProgress; i++) {
      await Future<void>.delayed(const Duration(seconds: 1), () async {
        final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('channel_id', 'Channel Name', 'Channel Description',
            channelShowBadge: false,
            importance: Importance.Max,
            priority: Priority.High,
            onlyAlertOnce: true,
            showProgress: true,
            maxProgress: maxProgress,
            progress: i);
        final NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails, null);
        await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification', 'Flutter Progress Notification',
            notificationDetails, payload: 'Destination Screen(Progress Notification)');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () => showSimpleNotification(),

                child: Text('Simple Notification',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
                  color: Colors.yellow[800]
                
              ),
              SizedBox(height: 50),
              RaisedButton(
                onPressed: () => showScheduleNotification(),

                child: Text('Schedule Notification',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
                  color: Colors.yellow[800]
                
              ),
              SizedBox(height: 50),
              RaisedButton(
                onPressed: () => showPeriodicNotification(),

                child: Text('Periodic Notification',
                  style: TextStyle(color: Colors.black, fontSize: 18) ),
                  color: Colors.yellow[800]
                
              ),
              SizedBox(height: 50),
              RaisedButton(
                onPressed: () => showBigPictureNotification(),

                child: Text('Big Picture Notification',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
                  color: Colors.yellow[800]
                
              ),
              
              SizedBox(height: 50),
              RaisedButton(
                onPressed: () => showProgressNotification(),
              
                child: Text('Progress Notification',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
                  color: Colors.yellow[800]
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
