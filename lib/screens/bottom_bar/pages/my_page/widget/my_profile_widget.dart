import 'package:coner_client/theme/colors.dart';
import 'package:coner_client/theme/decorations.dart';
import 'package:coner_client/theme/font_styles.dart';
import 'package:flutter/material.dart';

class MyProfileWidget extends StatelessWidget {
  const MyProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: profileDecoration,
          width: 156,
          height: 156,
          child: Image.asset("assets/images/icon_white.png"),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 24),
            Text('방문자', style: title2Bold),
            const SizedBox(width: 4),
            Icon(Icons.create_rounded, color: conerGrey, size: 20),
          ],
        ),
        const SizedBox(height: 8),
        Text('01055430636', style: body2Grey),
        Text('서울시 중랑구 중랑천로 43 신성아파트', style: body2Grey),
        Text('102동 901호  ', style: body2Grey),
      ],
    );
  }
}
