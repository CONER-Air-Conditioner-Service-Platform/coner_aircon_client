import 'package:flutter/cupertino.dart';

class WidgetSize {
  static double ratioOfHorizontal(BuildContext context, double i) {
    //가로 비율
    return MediaQuery.of(context).size.height * i;
  }

  static double ratioOfVertical(BuildContext context, double i) {
    //세로 비율
    return MediaQuery.of(context).size.width * i;
  }
}
