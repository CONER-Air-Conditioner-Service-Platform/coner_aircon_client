import 'package:coner_client/screens/widgets/my_app_bar.dart';
import 'package:coner_client/theme/app_size.dart';
import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../configs/router/route_names.dart';
import '../../theme/app_decorations.dart';

class RegionRestrictionNoticeScreen extends StatelessWidget {
  const RegionRestrictionNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          MyAppBar.noDecorations(context, () => context.pop()),
          Expanded(
              child: Column(
            children: [
              const Spacer(flex: 1),
              Lottie.asset("assets/animations/location.json", width: 200),
              Text("서비스지역이 아닙니다!", style: AppTextStyles.h2Bold),
              Text("현재 코너는 아래 지역들만 서비스가 가능해요.", style: AppTextStyles.b1),
              const SizedBox(height: 20),
              Text("서울 강북지역", style: AppTextStyles.s1Bold),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "도봉구, 동대문구, 은평구, 강북구, 관악구, 광진구, 종로구, 중랑구, 노원구, 성북구",
                  style: AppTextStyles.b1,
                ),
              ),
              const Spacer(flex: 2),
              Container(
                height: 52,
                width: AppSize.ratioOfHorizontal(context, 1) - 40,
                decoration: AppDecorations.gradientButtonDecoration,
                child: MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () => context.goNamed(RouteNames.profileUpdate),
                  child: Text('주소 변경하기', style: AppTextStyles.s1BoldWhite),
                ),
              ),
              const SizedBox(height: 4),
              TextButton(
                  onPressed: () => context.pop(),
                  child: Text("다음에 할래요", style: AppTextStyles.b2BoldUnderline)),
              SizedBox(height: AppSize.getBottomHeight(context) + 30),
            ],
          ))
        ],
      ),
    );
  }
}
