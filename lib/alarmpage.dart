import 'package:clockalarm/alarm_helper.dart';
import 'package:clockalarm/alarm_info.dart';
import 'package:clockalarm/data.dart';
import 'package:clockalarm/main.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class Aarmpage extends StatefulWidget
{
  const Aarmpage({Key? key}) : super(key: key);

  @override
  State<Aarmpage> createState() => _AarmpageState();
}

class _AarmpageState extends State<Aarmpage> {
  @override
  final _titlecontrol=TextEditingController();
  final _hourcontrol=TextEditingController();
  final _minutecontrol=TextEditingController();
  String DDD=  DateFormat('yyyy/MM/dd').format(DateTime.now());
  bool _validate=false;
  DateTime? _alarmTime;
  String _alarmTimeString=' ';


  bool _isRepeatSelected = false;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  List<AlarmInfo>? _currentAlarms;
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

  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
     //   mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Alarm',style: TextStyle(fontSize: 30,fontWeight:
          FontWeight.w700,color: Colors.white),),
         /*
         * Expanded(


          child: FutureBuilder<List<AlarmInfo>>(
    future: _alarms,
    builder: (context, snapshot) {
    if (snapshot.hasData) {
    _currentAlarms = snapshot.data;
    return ListView(
      children: alarms.map<Widget>((Alarmdata) {
        var alarmTime = DateFormat.yMd().add_jm().format(Alarmdata.alarmDateTime!);
        return Container(//16   8

          margin:const EdgeInsets.only(bottom: 30),
          padding:const EdgeInsets.symmetric(horizontal: 16,vertical: 8) ,
// color: Colors.black,

          decoration: BoxDecoration(
            gradient: LinearGradient(colors:[Colors.blue,Colors.white54],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)
            ,boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 8,
                spreadRadius: 4,
                offset: Offset(4, 4)
            ),
          ],borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:<Widget> [
                  Row(

                    children: <Widget>[
                      Icon(Icons.label,color: Colors.white,size: 24,),
                      SizedBox(width: 8,),
                      Text(Alarmdata.title!,style: TextStyle(color: Colors.white),),


                    ],
                  ),
                  Switch(value: true,
                    onChanged: (bool value){
                  }

                    ,activeColor: Colors.white,
                  ),

                ],
              ),
              Text(Alarmdata.alarmDateTime.toString()!,style: TextStyle(color: Colors.white),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:<Widget> [
                  Text(alarmTime,
                    style: TextStyle(color: Colors.white,
                        fontSize: 24,fontWeight: FontWeight.w700),),
                  IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.white,
                      onPressed: () {
                        _alarmHelper.delete(Alarmdata.id);
                        //unsubscribe for notification
                        loadAlarms();
                        deleteAlarm(Alarmdata.id);

                      }),
                ],

              )
              ,


            ],
          ),
        );
      }).followedBy([
        if(1>0)
      //  if (_currentAlarms!.length <99)
        DottedBorder(
            strokeWidth: 3,borderType: BorderType.RRect,
            color: Colors.blue,
            dashPattern: [5,4],
            radius: Radius.circular(24),
            child: Container(
                width: double.infinity,

                decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius:  BorderRadius.all(Radius.circular(24))
                ),
                height: 100,


                child: MaterialButton(onPressed: () {
// scheduleAlarm(alarmInfo, isRepeating: isRepeating);

                  _alarmTimeString = DateFormat.yMd().add_jm().format(DateTime.now());
                  showModalBottomSheet(
                    useRootNavigator: true,
                    context: context,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setModalState) {
                          return Container(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              children: [
                                Text(_alarmTimeString),

                                /*TextButton(
                                  onPressed: () async {
                                    var selectedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (selectedTime != null) {
                                      final now = DateTime.now();
                                      var selectedDateTime = DateTime(
                                          now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
                                      _alarmTime = selectedDateTime;
                                      setModalState(() {
                                        _alarmTimeString = DateFormat('HH:mm').format(selectedDateTime);
                                      });
                                    }
                                  },
                                  child: Text(
                                    _alarmTimeString,
                                    style: TextStyle(fontSize: 32),
                                  ),
                                ),
                                * */

                                ListTile(
                                  title:  TextField(controller: _Daycontrol,
                                    decoration: InputDecoration(
                                        errorText: _validate?'channal name is mad':null,
                                        border: const UnderlineInputBorder(
                                            borderSide: BorderSide(width: 1)
                                        ),hintText: '10/7/2023 10:30'
                                        'time  you need'
                                    ),

                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                ),
                                ListTile(
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
                                ListTile(
                                  title: Text('Sound'),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                ),
                                ListTile(
                                  title:  TextField(controller: _titlecontrol,
                          decoration: InputDecoration(
                              errorText: _validate?'channal name is mad':null,
                          border: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 1)
                          ),hintText: 'title you need'
                          ),

                          ),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                ),
                                FloatingActionButton.extended(
                                  onPressed: () {
                                    onSaveAlarm(_isRepeatSelected);
                                  },
                                  icon: Icon(Icons.alarm),
                                  label: Text('Save'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
// scheduleAlarm();
                },

                  child:Column
                    (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: <Widget>[
                      Icon(Icons.add_box_outlined,size: 30,),

                      Text('Add Alarm',style:
                      TextStyle(color: Colors.black,
                          fontSize: 16,fontWeight: FontWeight.w700),),


                    ],
                  )
                  ,)
            )

        )
    else
      Center(
          child: Text(
            'Only 5 alarms allowed!',
            style: TextStyle(color: Colors.white),
          )),
      ]

      ).toList()
    );

    }
    return Center(
      child:  DottedBorder(
          strokeWidth: 3,borderType: BorderType.RRect,
          color: Colors.blue,
          dashPattern: [5,4],
          radius: Radius.circular(24),
          child: Container(
              width: double.infinity,

              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius:  BorderRadius.all(Radius.circular(24))
              ),
              height: 100,


              child: MaterialButton(onPressed: () {
// scheduleAlarm(alarmInfo, isRepeating: isRepeating);

                _alarmTimeString = DateFormat.yMd().add_jm().format(DateTime.now());
                showModalBottomSheet(
                  useRootNavigator: true,
                  context: context,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setModalState) {
                        return Container(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              Text(_alarmTimeString),

                              /*TextButton(
                                  onPressed: () async {
                                    var selectedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (selectedTime != null) {
                                      final now = DateTime.now();
                                      var selectedDateTime = DateTime(
                                          now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
                                      _alarmTime = selectedDateTime;
                                      setModalState(() {
                                        _alarmTimeString = DateFormat('HH:mm').format(selectedDateTime);
                                      });
                                    }
                                  },
                                  child: Text(
                                    _alarmTimeString,
                                    style: TextStyle(fontSize: 32),
                                  ),
                                ),
                                * */

                              ListTile(
                                title:  TextField(controller: _Daycontrol,
                                  decoration: InputDecoration(
                                      errorText: _validate?'channal name is mad':null,
                                      border: const UnderlineInputBorder(
                                          borderSide: BorderSide(width: 1)
                                      ),hintText: '10/7/2023 10:30'
                                      'time  you need'
                                  ),

                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                              ListTile(
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
                              ListTile(
                                title: Text('Sound'),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                              ListTile(
                                title:  TextField(controller: _titlecontrol,
                                  decoration: InputDecoration(
                                      errorText: _validate?'channal name is mad':null,
                                      border: const UnderlineInputBorder(
                                          borderSide: BorderSide(width: 1)
                                      ),hintText: 'title you need'
                                  ),

                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                              FloatingActionButton.extended(
                                onPressed: () {
                                  _alarmTimeString = DateFormat.yMd().add_jm().format(DateTime.now());
                                  onSaveAlarm(_isRepeatSelected);
                                },
                                icon: Icon(Icons.alarm),
                                label: Text('Save'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
// scheduleAlarm();
              },

                child:Column
                  (
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[
                    Icon(Icons.add_box_outlined,size: 30,),

                    Text('Add Alarm',style:
                    TextStyle(color: Colors.black,
                        fontSize: 16,fontWeight: FontWeight.w700),),


                  ],
                )
                ,)
          )

      )
    );

    }
    )
          ),
         * */

        Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Text(DDD),

              /*TextButton(
                                  onPressed: () async {
                                    var selectedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (selectedTime != null) {
                                      final now = DateTime.now();
                                      var selectedDateTime = DateTime(
                                          now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
                                      _alarmTime = selectedDateTime;
                                      setModalState(() {
                                        _alarmTimeString = DateFormat('HH:mm').format(selectedDateTime);
                                      });
                                    }
                                  },
                                  child: Text(
                                    _alarmTimeString,
                                    style: TextStyle(fontSize: 32),
                                  ),
                                ),
                                * */

              ListTile(
                title:  TextField(controller: _hourcontrol,
                  decoration: InputDecoration(
                      errorText: _validate?'channal name is mad':null,
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 1)
                      ),hintText: '10/7/2023 10:30'
                      'time  you need'
                  ),

                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
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
              /*  ListTile(
                title: Text('Repeat'),
                trailing: Switch(
                  onChanged: (value) {
                    setModalState(() {
                      _isRepeatSelected = value;
                    });
                  },
                  value: _isRepeatSelected,
                ),
              ),*/

              const ListTile(
                title: Text('Sound'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title:  TextField(controller: _titlecontrol,
                  decoration: InputDecoration(
                      errorText: _validate?'channal name is mad':null,
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 1)
                      ),hintText: 'title you need'
                  ),

                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              FloatingActionButton.extended(
                onPressed: () {
               //   String DDD=  DateFormat('yyyy-MM-dd').format(DateTime.now());
                   String datetime=DDD+" "+_hourcontrol.text+':'+_minutecontrol.text+':00.123456789z';
                  //_alarmTimeString = DateFormat('HH:mm').format(selectedDateTime);


                    //_alarmTimeString = DateFormat('HH:mm').format(DateTime.parse(
                 // datetime
                 // ));

                   var selectedDateTime =
                   DateTime(DateTime.now().year,
                       DateTime.now().month,DateTime.now().day
                       , int.parse(_hourcontrol.text) , int.parse(_minutecontrol.text));
                   _alarmTime = selectedDateTime;
                   _alarmTimeString = DateFormat('HH:mm').format(selectedDateTime);

                  print(datetime);
                  print(_alarmTimeString);
                   print(selectedDateTime);
                 // _alarmTimeString = new DateTime();
                 
                  onSaveAlarm(_isRepeatSelected);
                },
                icon: const Icon(Icons.alarm),
                label: const Text('Save'),
              ),
            ],
          ),
        )

        ],
      ),
    ),

    );
  }
 Future < void> scheduleAlarm(DateTime scheduledNotificationDateTime,
      AlarmInfo alarmInfo, {required bool isRepeating}) async {
    var scheduledNotificationDateTime=DateTime.now()
        .add(const Duration(seconds: 10));
    var androidPlatformChannelSpecifics
    = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
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
    else {
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
  }

 /*
  void scheduleDayAlarm(DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo, {required bool isRepeating}) async {
    var scheduledNotificationDateTime=DateTime.now().add(Duration(seconds: 10));
    var androidPlatformChannelSpecifics
    = AndroidNotificationDetails(
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
        Day(
          scheduledNotificationDateTime.day,


        ) as Time,
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
  */
  void onSaveAlarm(bool _isRepeating) {
    DateTime? scheduleAlarmDateTime;

    if (_alarmTime!.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime!.add(const Duration(days: 1));

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      //alarmDateDay: scheduleAlarmDateTime,
     // gradientColorIndex: 1,
      title: _titlecontrol.text,
    );
    _alarmHelper.insertAlarm(alarmInfo);
    if (scheduleAlarmDateTime != null) {
      scheduleAlarm(scheduleAlarmDateTime,  alarmInfo, isRepeating: _isRepeating);
    }
  //  Navigator.pop(context);
    loadAlarms();
  }

  /**/

  void deleteAlarm(int? id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }
}
