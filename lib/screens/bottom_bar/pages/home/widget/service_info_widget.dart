import 'package:flutter/material.dart';

import '../../../../../theme/app_text_styles.dart';
import '../../../../../utils/service_request_util.dart';

class ServiceInfoWidget extends StatelessWidget {
  const ServiceInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("코너가 다루는 에어컨 종류", style: AppTextStyles.h2Bold),
          const SizedBox(height: 4),
          Text("창문형은 설치 서비스를 제공하지 않아요.", style: AppTextStyles.b1Grey),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 20),
                for (int i = 0; i < airconList.length; i++) ...[
                  airconMenuItem(airconImageList[i], airconList[i]),
                  SizedBox(width: 12),
                ]
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget airconMenuItem(String image, String title) {
    return Column(
      children: [
        Image.asset(image, width: 80, fit: BoxFit.contain),
        const SizedBox(height: 8),
        Text(title, style: AppTextStyles.b1),
      ],
    );
  }
}
