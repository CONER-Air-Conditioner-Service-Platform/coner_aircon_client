import 'package:flutter/cupertino.dart';

import '../../../../../theme/decorations.dart';
import '../../../../../theme/font_styles.dart';
import '../../../../../theme/widget_size.dart';

class MyPageAppbarWidget extends StatelessWidget {
  const MyPageAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: getStatusBarHeight(context) + 20, bottom: 10, left: 20, right: 20),
      decoration: itemBottomRadiusDecoration,
      child: Row(
        children: [
          Image.asset("assets/images/icon_color.png", width: 32, fit: BoxFit.contain),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text('방문자 님', style: title1Bold),
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}
