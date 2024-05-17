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
      "title": "에어컨 서비스의 새로운 패러다임",
      "text": "고객 중심의 서비스로 편리함과 안전을\n동시에 누릴 수 있는 혁신적인 플랫폼",
      "image": "assets/images/landing1.png"
    },
    {
      "title": "고객과 기사를 위한 완벽한 매칭",
      "text": "고객의 요구에 기사가 직접 응답하는\n혁신적인 매칭 시스템 도입",
      "image": "assets/images/landing2.png"
    },
    {
      "title": "에어컨 서비스의 미래,\n편리함과 만족을 넘어서",
      "text": "예약부터 서비스까지,\n고객과 기사를 위한 완벽한 서비스 플랫폼",
      "image": "assets/images/landing3.png"
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => AnimatedContainer(
                            duration: Duration(milliseconds: 100),
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
