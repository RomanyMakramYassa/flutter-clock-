import 'dart:async';

import 'package:clockalarm/HHHH.dart';
import 'package:clockalarm/alarmpage.dart';
import 'package:clockalarm/clock_view.dart';
import 'package:clockalarm/data.dart';
import 'package:clockalarm/enum.dart';
import 'package:clockalarm/menuinfi.dart';
import 'package:clockalarm/test1.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class homepage extends StatefulWidget
{


  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {

//print('hhhhh');
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var now=DateTime.now();
    var formattedtime=DateFormat('HH:MM').format(now);
    var formatteddate=DateFormat('EEE,d MMM').format(now);

    setState(() {
      formattedtime=DateFormat('HH:MM').format(now);
      
    });
    var Timezone=now.timeZoneOffset.toString().split('.').first;
    var offsetsign='';
    if(!Timezone.startsWith('-'))
      offsetsign='+';
    print(Timezone);
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Row(
        children: <Widget>[
          Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            TextButton(onPressed: (){},
                child: Column(

              children:menuItem.map((current)=>buldmanualbutton(current)).toList()
            )),


          ],),
          VerticalDivider(color: Colors.white,width: 1,),
          Expanded(

            child: Consumer<MenuInfo>
              (builder: (BuildContext context ,MenuInfo value , Widget? child){
              if (value.menuType==MenuType.clock)

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 60),
                alignment: Alignment.center,
                color: Colors.orangeAccent,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Text('Clock',style: TextStyle(color: Colors.white,fontSize:24),),),
                    SizedBox(height: 30,),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget> [
                          DigitalClockWidget(),
                        //  Text(formattedtime,style: TextStyle(color: Colors.white,fontSize:64),),
                          Text(formatteddate,style: TextStyle(color: Colors.white,fontSize:20),),

                        ],),),
                    Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.center,
                          child: ClockView(size: MediaQuery.of(context).size.height/4,),
                        ) ),

                    Flexible(
                        flex:2,
                        fit: FlexFit.tight,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:<Widget> [

                            Text('TimeZone',style: TextStyle(color: Colors.white,fontSize:20),),
                            Row(children: <Widget>[
                              Icon(Icons.language,color: Colors.white,)
                              ,SizedBox(width: 10,)
                              , Text('UTC'+offsetsign+Timezone,style: TextStyle(color: Colors.white,fontSize:24),),
                            ],),
                          ],))
                  ],
                ),

              );
              else if (value.menuType==MenuType.alarm)
                return AlarmPage1();
              else return Container();
            },),),
        ],
      )
    );

  }
  Widget buldmanualbutton(MenuInfo CurrentMenuInfo){
    return Consumer<MenuInfo>(builder:(BuildContext context,MenuInfo value,Widget? child){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        color: CurrentMenuInfo.menuType==value.menuType?Colors.white54:Colors.transparent,
        child: TextButton(

            onPressed: (){
        var menuInfo = Provider.of<MenuInfo>(context,listen: false);
        menuInfo.updateMenu(CurrentMenuInfo);
      },

          child: Column(
            children:<Widget> [
              Image.asset(CurrentMenuInfo.imagesource,scale:1.5,height: 40,width: 30,),
              Text(CurrentMenuInfo.title??' '
                ,style: TextStyle(color: Colors.white,fontSize: 14),

              )
            ],
          )
      )
        ,);
    },

    );
  }




}

class DigitalClockWidget extends StatefulWidget {
  const DigitalClockWidget({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DigitalClockWidgetState();
  }
}

class DigitalClockWidgetState extends State<DigitalClockWidget> {
  var formattedTime = DateFormat('HH:mm').format(DateTime.now());
  late Timer timer;

  @override
  void initState() {
    this.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      var perviousMinute = DateTime.now().add(Duration(seconds: -1)).minute;
      var currentMinute = DateTime.now().minute;
      if (perviousMinute != currentMinute)
        setState(() {
          formattedTime = DateFormat('HH:mm').format(DateTime.now());
        });
    });
    super.initState();
  }

  @override
  void dispose() {
    this.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('=====>digital clock updated');
    return Text(
      formattedTime,
      style: TextStyle( color: Colors.white, fontSize: 64),
    );
  }
/*
* const Color white = Colors.white;
const Color primaryColor = Color(-158912);
const Color red = Colors.red;
const Color black = Colors.black;
const Color grey = Color.fromRGBO(158,158,158,2);
const kAnimationDuration = Duration(milliseconds: 200);
const defaultDuration = Duration(milliseconds: 250);
* */
}
