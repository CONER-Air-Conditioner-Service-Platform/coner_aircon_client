import 'package:coner_client/theme/app_size.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../theme/app_decorations.dart';
import '../../../../../theme/app_text_styles.dart';

class MyPageAppbarWidget extends StatelessWidget {
  const MyPageAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: AppSize.getStatusBarHeight(context) + 20, bottom: 10, left: 20, right: 20),
      decoration: AppDecorations.bottomRadiusDecoration,
      child: Row(
        children: [
          Image.asset("assets/images/icon_color.png", width: 32, fit: BoxFit.contain),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text('내 정보', style: AppTextStyles.b1Bold),
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}
