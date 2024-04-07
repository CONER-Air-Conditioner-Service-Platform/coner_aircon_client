import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../theme/app_decorations.dart';
import '../../../../../theme/app_text_styles.dart';
import '../../../../theme/app_size.dart';

class RequestExampleImageAppbar extends StatelessWidget {
  const RequestExampleImageAppbar({super.key});

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
              onPressed: () => context.pop(),
              icon: const Icon(CupertinoIcons.back, size: 24),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text('추가 관련 사진 예시', style: AppTextStyles.s1Bold),
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}
