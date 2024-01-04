import 'package:coner_client/screens/bottom_bar/pages/home/widget/request_tab_bar_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/font_styles.dart';

class RequestWidget extends StatelessWidget {
  const RequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('의뢰하기', style: title1Bold),
        ),
        const RequestTabBarWidget(),
        SizedBox(height: 8),
      ],
    );
  }
}
