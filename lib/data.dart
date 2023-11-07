import 'package:clockalarm/enum.dart';
import 'package:clockalarm/menuinfi.dart';
import 'package:clockalarm/alarm_info.dart';

List<MenuInfo> menuItem=[
  MenuInfo(MenuType.clock,imagesource: 'assset/clock.jpeg', title: 'clock'),
  MenuInfo(MenuType.alarm,imagesource: 'assset/alarm.jpeg', title: 'Alarm '),
  MenuInfo(MenuType.stopwatch,  imagesource:'assset/stop.jpeg', title: ' Stop' ),
  MenuInfo(MenuType.timer,  imagesource: 'assset/clock.jpeg', title: 'clock')
];
List<AlarmInfo> alarms = [
  AlarmInfo(alarmDateTime: DateTime.now().add(Duration(hours: 1)), title: 'Office',
      ),
  AlarmInfo(alarmDateTime: DateTime.now().add(Duration(hours: 2)), title: 'Sport'
      , ),
];