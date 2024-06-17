import 'package:coner_client/configs/router/route_names.dart';
import 'package:coner_client/screens/landing/widgets/landing_content.dart';
import 'package:coner_client/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_decorations.dart';
import '../../theme/app_size.dart';
import '../../theme/app_text_styles.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "title": "원하는 날, 원하는 시간대에 예약",
      "text": "신청하신 날짜와 시간대에\n일정이 비어있는 협업 업체를 찾아 연결해드려요.",
      "image": "assets/images/landing1.png"
    },
    {
      "title": "쉬운 의뢰서 작성",
      "text": "의뢰서를 작성하는 시간은 평균 5분!\n누구나 쉽게 작성할 수 있어요.",
      "image": "assets/images/landing3.png"
    },
    {
      "title": "언제, 어디서나, 편리하게",
      "text": "이젠 어플 하나로 시간과 장소 상관 없이\n에어컨 서비스를 관리하세요.",
      "image": "assets/images/landing2.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => LandingContent(
                    title: splashData[index]["title"],
                    image: splashData[index]["image"],
                    text: splashData[index]['text'],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            margin: const EdgeInsets.only(right: 5),
                            height: 6,
                            width: currentPage == index ? 20 : 6,
                            decoration: BoxDecoration(
                              color:
                                  currentPage == index ? AppColors.coner2 : const Color(0xFFD8D8D8),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 1),
                      Container(
                        height: 52,
                        width: AppSize.ratioOfHorizontal(context, 1) - 40,
                        decoration: AppDecorations.gradientButtonDecoration,
                        child: MaterialButton(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onPressed: () => context.pushNamed(RouteNames.signIn),
                          child: Text('시작하기', style: AppTextStyles.s1BoldWhite),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextButton(
                          onPressed: () => context.pushNamed(RouteNames.main),
                          child: Text("서비스 둘러보기", style: AppTextStyles.b2BoldUnderline)),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
