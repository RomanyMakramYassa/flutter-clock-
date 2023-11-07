import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockView extends StatefulWidget
{
  final double size;
  const ClockView({Key? key,  required this.size}) : super(key: key);

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Align(

      alignment: Alignment.topCenter,
      child: Container(
          width: widget.size,
          height: widget.size,
          child:Transform.rotate(angle: -pi/2
            ,child:  CustomPaint(
              painter:ClockPointer() ,
            ),)
      ),
    );
  }
}
class ClockPointer extends CustomPainter{
  var data= DateTime.now();
  var year=DateFormat.y().format(DateTime.now());

  var dataTime=DateTime.now();

  void paint(Canvas canvas,Size size){
    var centerx=size.width/2;
    var centery=size.height/2;
    var center =Offset(centerx, centery);
    var radius=min(centerx, centery);
    var fillBrush=Paint()..color=Colors.orangeAccent;
    var dashBrush=Paint()..color=Colors.black;
    var outlineBrush=Paint()..color=Colors.white54..style=PaintingStyle.stroke..strokeWidth=size.width/20;
    var centerineBrush=Paint()..color=Colors.white54..style=PaintingStyle.stroke..strokeWidth=size.width/20;
    var sechandBrush=Paint()..color=Colors.black..style=PaintingStyle.stroke..
    strokeCap=StrokeCap.round..strokeWidth=size.width/60;
    var minhandBrush=Paint()..shader=RadialGradient(colors: [Colors.lightBlue,Colors.pink])
        .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style=PaintingStyle.stroke..strokeCap=StrokeCap.round..strokeWidth=size.width/30;
    var hourhandBrush=Paint()..shader=RadialGradient(colors: [Colors.indigo,Colors.pink])
        .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style=PaintingStyle.stroke..strokeCap=StrokeCap.round..strokeWidth=size.width/24;

    canvas.drawCircle(center, radius*0.75, fillBrush);
    canvas.drawCircle(center, radius*0.75, outlineBrush);
    canvas.drawCircle(center, radius*0.12, centerineBrush);



    var sechandx=centerx+radius*0.6*cos(dataTime.second*6*pi/180);
    var sechandy=centerx+radius*0.6*sin(dataTime.second*6*pi/180);
    canvas.drawLine(center,Offset(sechandx, sechandy), sechandBrush);
    var minhandx=centerx+radius*0.5*cos(dataTime.minute*6*pi/180);
    var minhandy=centerx+radius*0.5*sin(dataTime.minute*6*pi/180);
    canvas.drawLine(center,Offset(minhandx, minhandy), minhandBrush);
    var hourhandx=centerx+radius*0.4*cos((dataTime.hour*30+dataTime.minute*0.5)*pi/180);
    var hourhandy=centerx+radius*0.4*sin((dataTime.hour*30+dataTime.minute*0.5)*pi/180);
    canvas.drawLine(center,Offset(hourhandx, hourhandy), hourhandBrush);
    var outercircleradius=radius;
    var innercircleradius=radius*0.9;
    for(double i=0;i<360;i+=12){
      var x1=centerx+outercircleradius*cos(i*pi/180);
      var y1=centerx+outercircleradius*sin(i*pi/180);
      var x2=centerx+innercircleradius*cos(i*pi/180);
      var y2=centerx+innercircleradius*sin(i*pi/180);
      canvas.drawLine(Offset(x1,y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {

    return true;

  }

}