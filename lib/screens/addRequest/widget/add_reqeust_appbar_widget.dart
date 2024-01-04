import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../theme/decorations.dart';
import '../../../../../theme/font_styles.dart';
import '../../../../../theme/widget_size.dart';

class AddRequestAppbarWidget extends StatelessWidget {
  const AddRequestAppbarWidget({super.key});

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
                onPressed: () => context.pop(), icon: Icon(CupertinoIcons.back, size: 24)),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('방문자 님', style: title1Bold), Text('의 의뢰서', style: title1)],
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}
