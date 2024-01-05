import 'package:coner_client/theme/font_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/decorations.dart';

class SystemMenuWidget extends StatelessWidget {
  const SystemMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12, left: 20, right: 20),
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 28),
      decoration: whiteBorderDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(onPressed: () {}, child: Text('개인정보처리방침', style: body1)),
        ],
      ),
    );
  }
}
