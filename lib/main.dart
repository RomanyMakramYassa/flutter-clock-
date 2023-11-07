import 'package:clockalarm/enum.dart';
import 'package:clockalarm/menuinfi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import 'homepagge.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=
FlutterLocalNotificationsPlugin();

void main() async{


  var day=DateFormat.EEEE().format(DateTime.now());
  print('yaer : $day');

  var year= DateFormat('yyyy-MM-dd').format(DateTime.now());
  print(year);





  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid=AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {});
  var initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
 onDidReceiveNotificationResponse:(NotificationResponse payload)  {
        if (payload != null) {
          debugPrint('notification payload: ' + payload.payload.toString());
        }
      } );

  /*var initializationSetttingsIOS=IOSInitializationSettings(
      (this.requestAlertPermission = true,
        this.requestSoundPermission = true,
        this.requestBadgePermission = true,
        this.defaultPresentAlert = true,
        this.defaultPresentSound = true,
        this.defaultPresentBadge = true,
        this.onDidReceiveLocalNotification: (int id,String title ,String body,String payload)async{});*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<MenuInfo>(create: (BuildContext context)
      =>MenuInfo(MenuType.clock, imagesource: 'assset/clock.jpeg', title: 'clock', ),
      child: homepage(),),
    );
  }
}

