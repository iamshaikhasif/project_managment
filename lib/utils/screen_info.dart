import 'package:flutter/cupertino.dart';

class ScreenInfo {

  static late Size deviceSize;
  static double deviceHeight = 0;
  static double deviceWidth = 0;


  static void init({required BuildContext context}){
    deviceSize = MediaQuery.of(context).size;
    deviceHeight = deviceSize.height;
    deviceWidth = deviceSize.width;
  }

}