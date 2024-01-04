import 'package:flutter/material.dart';

import 'colors.dart';

BoxDecoration itemBottomRadiusDecoration = const BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(10),
    bottomRight: Radius.circular(10),
  ),
  boxShadow: [BoxShadow(blurRadius: 2, color: Colors.grey)],
);

BoxDecoration conerColorDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [conerColor1, conerColor2, conerColor3],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
);
BoxDecoration cancleButtonDecoration = BoxDecoration(
  color: Color(0xffD9D9D9),
  borderRadius: BorderRadius.circular(10),
);

BoxDecoration buttonDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [conerColor1, conerColor2, conerColor3],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  borderRadius: BorderRadius.circular(10),
);

BoxDecoration profileDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [conerColor1, conerColor2, conerColor3],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  borderRadius: BorderRadius.circular(100),
  image: const DecorationImage(
    image: AssetImage("assets/images/icon_white.png"),
    fit: BoxFit.contain,
  ),
);
