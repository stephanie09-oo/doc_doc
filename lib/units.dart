

import 'package:flutter/cupertino.dart';

class Units{
  static const figmaWidth=390;
  static const figmaHeight=812;

  static double getWidth({
    required BuildContext context,
    required double widgetwidth,
  })=>(MediaQuery.of(context).size.width*widgetwidth)/figmaWidth;

  static double getHeight({
    required BuildContext context,
    required double widgetheight,
  })=>(MediaQuery.of(context).size.height*widgetheight)/figmaHeight;
}