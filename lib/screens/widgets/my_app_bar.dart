import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/app_assets.dart';
import '../../theme/app_decorations.dart';
import '../../theme/app_size.dart';
import '../../theme/app_text_styles.dart';

class MyAppBar {
  MyAppBar._();
  static Widget noDecorations(context, void Function() function) {
    return Container(
      padding: EdgeInsets.only(top: AppSize.getStatusBarHeight(context), left: 8),
      alignment: Alignment.centerLeft,
      child: IconButton(onPressed: function, icon: const Icon(CupertinoIcons.back, size: 32)),
    );
  }

  static Widget basic(context, String title1, String title2) {
    return Container(
      padding: EdgeInsets.only(
          top: AppSize.getStatusBarHeight(context) + 20, bottom: 10, left: 20, right: 20),
      decoration: AppDecorations.bottomRadiusDecoration,
      child: Row(
        children: [
          Image.asset(AppAssets.iconColor, width: 32, fit: BoxFit.contain),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title1, style: AppTextStyles.s1Bold),
                Text(title2, style: AppTextStyles.s1),
              ],
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }

  static Widget backBtn(BuildContext context, String title, void Function() function) {
    return Container(
      padding: EdgeInsets.only(top: 12 + AppSize.getStatusBarHeight(context), left: 12, right: 20),
      decoration: AppDecorations.bottomRadiusDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: IconButton(onPressed: function, icon: const Icon(CupertinoIcons.back, size: 24)),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(title, style: AppTextStyles.b1Bold),
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}
