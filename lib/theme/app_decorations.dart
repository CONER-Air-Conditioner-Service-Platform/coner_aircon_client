import 'package:coner_client/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppDecorations {
  AppDecorations._();
  static BoxDecoration bottomRadiusDecoration = const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10),
    ),
    boxShadow: [BoxShadow(blurRadius: 2, color: Colors.grey)],
  );

  static BoxDecoration gradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [AppColors.coner1, AppColors.coner2, AppColors.coner3],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  static BoxDecoration gradientButtonDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [AppColors.coner1, AppColors.coner2, AppColors.coner3],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(10),
  );

  static BoxDecoration buttonDecoration(Color? color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    );
  }

  static BoxDecoration profileDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [AppColors.coner1, AppColors.coner2, AppColors.coner3],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(100),
  );
}
