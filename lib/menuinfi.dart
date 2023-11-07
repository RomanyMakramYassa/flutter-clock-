import 'package:clockalarm/enum.dart';
import 'package:flutter/widgets.dart';

class MenuInfo extends ChangeNotifier{
  MenuType menuType;
  String title;
  String imagesource;
  MenuInfo(this.menuType,  {required this.imagesource ,required this.title});

  updateMenu(MenuInfo menuInfo){
    this.menuType=menuInfo.menuType;
    this.title=menuInfo.title;
    this.imagesource=menuInfo.imagesource;
    notifyListeners();

  }


}