import 'package:flutter/material.dart';

import '../../../../../theme/decorations.dart';
import '../../../../../theme/font_styles.dart';
import '../../../../../theme/widget_size.dart';
import '../../../../../utils/image_util.dart';

class PrograssWidget extends StatelessWidget {
  const PrograssWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: itemBottomRadiusDecoration,
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: getStatusBarHeight(context), bottom: 28),
              child: Image.asset("assets/images/logo_color.png", width: 116, fit: BoxFit.contain),
            ),
            matchingCompletedHelper()
          ],
        ),
      ),
    );
  }

  Widget guestHelper() {
    return Column(
      children: [
        Row(
          children: [
            Text('방문자 님', style: title1Bold),
            Text('의 서비스 진행도', style: title1),
          ],
        ),
        const SizedBox(height: 16),
        Image.asset("assets/images/prograss_bar1.png", width: 416, fit: BoxFit.contain),
        const SizedBox(height: 44),
        Column(
          children: [
            Text('코너를 이용하시려면 로그인이 필요해요!', style: body2),
            const SizedBox(height: 12),
            TextButton(onPressed: () {}, child: Text('로그인 하러가기', style: body1Button)),
          ],
        ),
        const SizedBox(height: 44),
      ],
    );
  }

  Widget noRequestHelper() {
    return Column(
      children: [
        Row(
          children: [
            Text('방문자 님', style: title1Bold),
            Text('의 서비스 진행도', style: title1),
          ],
        ),
        const SizedBox(height: 16),
        Image.asset("assets/images/prograss_bar1.png", width: 416, fit: BoxFit.contain),
        const SizedBox(height: 44),
        Column(
          children: [
            Text('아직 진행중인 의뢰가 없습니다!', style: body2),
            const SizedBox(height: 12),
            TextButton(onPressed: () {}, child: Text('의뢰 하러가기', style: body1Button)),
          ],
        ),
        const SizedBox(height: 44),
      ],
    );
  }

  Widget submissionCompletedHelper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('방문자 님', style: title1Bold),
            Text('의 서비스 진행도', style: title1),
          ],
        ),
        const SizedBox(height: 16),
        Image.asset("assets/images/prograss_bar2.png", width: 416, fit: BoxFit.contain),
        const SizedBox(height: 16),
        Row(
          children: [
            Text('접수가 완료', style: body1Bold),
            Text('되었습니다!', style: body1),
          ],
        ),
        Text('며칠 내로 근처에 있는 기사님이 배치될 예정이에요!', style: body1),
        const SizedBox(height: 60),
        Row(
          children: [
            Image.asset("assets/images/tag_ceiling.png", fit: BoxFit.contain),
            SizedBox(width: 4),
            Image.asset("assets/images/tag_repair.png", fit: BoxFit.contain),
            SizedBox(width: 12),
            Expanded(
              child: Text('서울시 성북구 안암로 145', style: body1),
            ),
            TextButton(onPressed: () {}, child: Text('자세히 보기', style: body2Grey)),
          ],
        ),
      ],
    );
  }

  Widget matchingCompletedHelper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('방문자 님', style: title1Bold),
            Text('의 서비스 진행도', style: title1),
          ],
        ),
        const SizedBox(height: 16),
        Image.asset("assets/images/prograss_bar3.png", width: 416, fit: BoxFit.contain),
        const SizedBox(height: 16),
        Row(
          children: [
            profileImageWidget(48, null),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('홍길동 기사님', style: body2Bold),
                    Text('이 배정되었습니다.', style: body2),
                  ],
                ),
                Text('2023년 12월 27일에 방문 예정입니다.', style: body2),
              ],
            )
          ],
        ),
        const SizedBox(height: 57),
        Row(
          children: [
            Image.asset("assets/images/tag_ceiling.png", fit: BoxFit.contain),
            SizedBox(width: 4),
            Image.asset("assets/images/tag_repair.png", fit: BoxFit.contain),
            SizedBox(width: 12),
            Expanded(
              child: Text('서울시 성북구 안암로 145', style: body1),
            ),
            TextButton(onPressed: () {}, child: Text('자세히 보기', style: body2Grey)),
          ],
        ),
      ],
    );
  }

  Widget visitTodayHelper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('방문자 님', style: title1Bold),
            Text('의 서비스 진행도', style: title1),
          ],
        ),
        const SizedBox(height: 16),
        Image.asset("assets/images/prograss_bar4.png", width: 416, fit: BoxFit.contain),
        const SizedBox(height: 16),
        Row(
          children: [
            profileImageWidget(48, null),
            SizedBox(width: 10),
            Row(
              children: [
                Text('홍길동 기사님', style: body2Bold),
                Text('이 오늘 방문하실 예정입니다!', style: body2),
              ],
            ),
          ],
        ),
        const SizedBox(height: 60),
        Row(
          children: [
            Image.asset("assets/images/tag_ceiling.png", fit: BoxFit.contain),
            SizedBox(width: 4),
            Image.asset("assets/images/tag_repair.png", fit: BoxFit.contain),
            SizedBox(width: 12),
            Expanded(
              child: Text('서울시 성북구 안암로 145', style: body1),
            ),
            TextButton(onPressed: () {}, child: Text('자세히 보기', style: body2Grey)),
          ],
        ),
      ],
    );
  }

  Widget awaitingPaymentHelper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('방문자 님', style: title1Bold),
            Text('의 서비스 진행도', style: title1),
          ],
        ),
        const SizedBox(height: 16),
        Image.asset("assets/images/prograss_bar5.png", width: 416, fit: BoxFit.contain),
        const SizedBox(height: 16),
        Row(
          children: [
            Text('결제 대기중', style: body1Bold),
            Text('입니다.', style: body1),
          ],
        ),
        Text('결제를 완료하여 주세요!', style: body1),
        const SizedBox(height: 60),
        Row(
          children: [
            Image.asset("assets/images/tag_ceiling.png", fit: BoxFit.contain),
            SizedBox(width: 4),
            Image.asset("assets/images/tag_repair.png", fit: BoxFit.contain),
            SizedBox(width: 12),
            Expanded(
              child: Text('서울시 성북구 안암로 145', style: body1),
            ),
            TextButton(onPressed: () {}, child: Text('자세히 보기', style: body2Grey)),
          ],
        ),
      ],
    );
  }
}
