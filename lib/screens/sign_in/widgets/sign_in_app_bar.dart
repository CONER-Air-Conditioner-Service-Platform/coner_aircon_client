import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/decorations.dart';
import '../../../theme/font_styles.dart';
import '../../../theme/widget_size.dart';

class SignInAppBar extends StatelessWidget {
  const SignInAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: getStatusBarHeight(context) + 12, left: 12, right: 20),
      decoration: itemBottomRadiusDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: IconButton(
                onPressed: () => context.pop(), icon: const Icon(CupertinoIcons.back, size: 24)),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text('로그인', style: title1Bold),
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}
