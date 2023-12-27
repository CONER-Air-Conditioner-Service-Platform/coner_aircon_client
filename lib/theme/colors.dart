import 'package:flutter/cupertino.dart';

Color conerColor1 = const Color(0xFF00E6FF);
Color conerColor2 = const Color(0xFF00E5FD);
Color conerColor3 = const Color(0xcc00CCCC);

BoxDecoration conerColorDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [conerColor1, conerColor2, conerColor3],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
);
