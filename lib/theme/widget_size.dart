import 'package:flutter/cupertino.dart';

double ratioOfHorizontal(BuildContext context, double i) {
  //가로 비율
  return MediaQuery.of(context).size.height * i;
}

double ratioOfVertical(BuildContext context, double i) {
  //세로 비율
  return MediaQuery.of(context).size.width * i;
}

double getStatusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}
