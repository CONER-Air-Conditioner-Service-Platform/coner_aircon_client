import 'package:coner_client/theme/app_assets.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../theme/app_decorations.dart';
import '../../../../../theme/app_size.dart';
import '../../../../../theme/app_text_styles.dart';

class RequestAppbarWidget extends StatelessWidget {
  const RequestAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                Text('방문자 님', style: AppTextStyles.b2Bold),
                Text('의 의뢰서', style: AppTextStyles.b2),
              ],
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}
