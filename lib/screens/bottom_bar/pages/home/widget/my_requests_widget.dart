import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/font_styles.dart';

class MyRequestsWidget extends StatelessWidget {
  const MyRequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('최근 내 의뢰', style: title1Bold),
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
                Text('2023.12.29', style: body1Grey),
                const SizedBox(width: 12),
                Text('홍길동 기사님', style: body1Grey),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Image.asset("assets/images/tag_ceiling.png", fit: BoxFit.contain),
                const SizedBox(width: 4),
                Image.asset("assets/images/tag_repair.png", fit: BoxFit.contain),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('서울시 성북구 안암로 145', style: body1),
                ),
              ],
            ),
          ],
        ),
      );
}
