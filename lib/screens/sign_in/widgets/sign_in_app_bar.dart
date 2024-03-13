import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../provider/phone_verification_provider.dart';
import '../../../theme/app_decorations.dart';
import '../../../theme/app_size.dart';
import '../../../theme/app_text_styles.dart';

class SignInAppBar extends StatelessWidget {
  const SignInAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: AppSize.getStatusBarHeight(context) + 12, left: 12, right: 20),
      decoration: AppDecorations.bottomRadiusDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: IconButton(
                onPressed: () {
                  Provider.of<PhoneVerificationProvider>(context, listen: false).clear();
                  context.pop();
                },
                icon: const Icon(CupertinoIcons.back, size: 24)),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text('로그인', style: AppTextStyles.b1Bold),
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}
