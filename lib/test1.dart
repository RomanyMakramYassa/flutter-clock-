import 'package:clockalarm/alarm_helper.dart';
import 'package:clockalarm/main.dart';

//import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;


import 'alarm_info.dart';

class AlarmPage1 extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage1> {
  DateTime? _alarmTime;
  late String _alarmTimeString;
  final _hourcontrol=TextEditingController();
  final _titlecontrol=TextEditingController();
  final _minutecontrol=TextEditingController();
  String DDD=  DateFormat('yyyy/MM/dd').format(DateTime.now());
  bool _validate=false;

  bool _isRepeatSelected = true;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  List<AlarmInfo>? _currentAlarms;

  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Alarm',
            style:
            TextStyle(
              //fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: Colors.black, fontSize: 24),
          ),

          StatefulBuilder(builder:  (context, setModalState) {
    return Container(
    padding: const EdgeInsets.all(10),
    child: SingleChildScrollView(child: Column(
      children: [


        ListTile(
          title:  TextField(controller: _hourcontrol,
            decoration: InputDecoration(
                errorText: _validate?'channal name is mad':null,
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 1)
                ),hintText: ' 10:30'
                'time  you need'
            ),

          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        SizedBox(height: 10,),
        ListTile(
          title:  TextField(controller: _minutecontrol,
            decoration: InputDecoration(
                errorText: _validate?'channal name is mad':null,
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 1)
                ),hintText: '30'
                'minute  you need'
            ),

          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),

SizedBox(height: 10,),
    /*
    *  ListTile(
          title: Text('Repeat'),
          trailing: Switch(
            onChanged: (value) {
              setModalState(() {
                _isRepeatSelected = value;
              });
            },
            value: _isRepeatSelected,
          ),
        ),

    * */

        SizedBox(height: 10,),
        ListTile(
          title:  TextField(controller: _titlecontrol,
            decoration: InputDecoration(
                errorText: _validate?'channal name is mad':null,
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 1)
                ),hintText: '30'
                'title you need'
            ),

          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        SizedBox(height: 10,),
        FloatingActionButton.extended(
          onPressed: () {
            var selectedDateTime = DateTime(
                DateTime.now().year, DateTime.now().month,

                DateTime.now().day, int.parse(_hourcontrol.text)
                , int.parse(_minutecontrol.text));
            _alarmTime = selectedDateTime;
            setState(() {
              _alarmTimeString
              = DateFormat('HH:mm').format(selectedDateTime);
            });
            onSaveAlarm(_isRepeatSelected);
            _titlecontrol.text='';
            _hourcontrol.text='';
            _minutecontrol.text='';
                      },
          icon: Icon(Icons.alarm),
          label: Text('Save'),
        ),
      ],
    ),)
    );
    }, ),



        ],
      ),
    );
  }

  void scheduleAlarm(DateTime scheduledNotificationDateTime,
      AlarmInfo alarmInfo, {required bool isRepeating}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    if (isRepeating)
      await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        _titlecontrol.text,
        alarmInfo.title,
        Time(
          scheduledNotificationDateTime.hour,
          scheduledNotificationDateTime.minute,
          scheduledNotificationDateTime.second,
        ),
        platformChannelSpecifics,
      );
    else
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        _titlecontrol.text,
        alarmInfo.title,
        tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
  }

  void onSaveAlarm(bool _isRepeating) {
    DateTime? scheduleAlarmDateTime;
    if (_alarmTime!.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime!.add(Duration(days: 1));

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      //  gradientColorIndex: _currentAlarms!.length,
      title: 'alarm',
    );
    _alarmHelper.insertAlarm(alarmInfo);
    if (scheduleAlarmDateTime != null) {
      scheduleAlarm(scheduleAlarmDateTime, alarmInfo, isRepeating: _isRepeating);
    }
   // Navigator.pop(context);

    loadAlarms();
  }

  void deleteAlarm(int? id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }
}