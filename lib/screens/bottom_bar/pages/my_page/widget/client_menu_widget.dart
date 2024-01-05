import 'package:coner_client/theme/font_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/decorations.dart';

class ClientMenuWidget extends StatelessWidget {
  const ClientMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 28, left: 20, right: 20),
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 28),
      decoration: whiteBorderDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(onPressed: () {}, child: Text('공지사항', style: body1)),
          TextButton(onPressed: () {}, child: Text('문의하기', style: body1)),
        ],
      ),
    );
  }
}
