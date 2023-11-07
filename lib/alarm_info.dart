

/*
* class AlarmInfo{
  DateTime alarmdatatime;
  String discribtion;
  bool isactive;
  AlarmInfo(this.isactive,{required this.alarmdatatime,required this.discribtion});
*
* */
class AlarmInfo {
int? id;
String? title;
DateTime? alarmDateTime;

//DateTime? alarmDateDay;
bool? isPending;

//int? gradientColorIndex;

AlarmInfo(
{this.id,
this.title,
this.alarmDateTime,
 // this.alarmDateDay,
this.isPending,
//this.gradientColorIndex
});

factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
id: json["id"],
title: json["title"],
alarmDateTime: DateTime.parse(json["alarmDateTime"]),
  ///alarmDateDay: DateTime.parse(json["alarmDateDay"]),
isPending: json["isPending"],
//gradientColorIndex: json["gradientColorIndex"],
);
Map<String, dynamic> toMap() => {
"id": id,
"title": title,
"alarmDateTime": alarmDateTime!.toIso8601String(),
  //"alarmDateDay": alarmDateDay!.toIso8601String(),
"isPending": isPending,
//"gradientColorIndex": gradientColorIndex,
};
}