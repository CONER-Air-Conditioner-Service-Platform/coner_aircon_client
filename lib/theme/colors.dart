import 'package:flutter/cupertino.dart';

Color conerColor1 = const Color(0xFF00E6FF);
Color conerColor2 = const Color(0xFF00E5FD);
Color conerColor3 = const Color(0xcc00CCCC);
Color conerGrey = const Color(0xFFD9D9D9);
Color conerBlack = const Color(0xff0B0B0B);
Color conerBackgroundColor = const Color(0xffF8F8F8);
BoxDecoration conerColorDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [conerColor1, conerColor2, conerColor3],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
);
