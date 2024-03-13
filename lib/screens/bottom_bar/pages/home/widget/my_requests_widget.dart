import 'package:coner_client/provider/client_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../theme/app_text_styles.dart';

class MyRequestsWidget extends StatelessWidget {
  const MyRequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('최근 내 의뢰', style: AppTextStyles.h2Bold),
          const SizedBox(height: 12),
          requestItem(),
          const SizedBox(height: 8),
          requestItem(),
          const SizedBox(height: 8),
          requestItem(),
        ],
      ),
    );
  }

  Widget requestItem() => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xffA0A0A0),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text('2023.11.21', style: AppTextStyles.b2Grey),
                const SizedBox(width: 12),
                Text('홍길동 기사님', style: AppTextStyles.b2Grey),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Image.asset("assets/images/tag_ceiling.png", height: 22, fit: BoxFit.contain),
                const SizedBox(width: 4),
                Image.asset("assets/images/tag_repair.png", height: 22, fit: BoxFit.contain),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('서울시 성북구 안암로 145', style: AppTextStyles.b2),
                ),
              ],
            ),
          ],
        ),
      );
}
