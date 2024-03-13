import 'package:coner_client/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../configs/router/route_names.dart';
import '../../../../../provider/client_provider.dart';
import '../../../../../theme/app_assets.dart';
import '../../../../../theme/app_text_styles.dart';

class ServicePrograssWidget extends StatelessWidget {
  const ServicePrograssWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('내 의뢰 현황', style: AppTextStyles.h2Bold),
          const SizedBox(height: 12),
          if (clientProvider.clientId == '') ...[
            Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: AppColors.coner2),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("서비스를 이용하시려면 로그인이 필요합니다.", style: AppTextStyles.b1),
                    TextButton(
                      onPressed: () => context.goNamed(RouteNames.signIn),
                      child: Text(
                        "로그인 하러가기",
                        style: AppTextStyles.b1BoldUnderline,
                      ),
                    ),
                  ],
                )),
          ] else ...[
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: AppColors.coner2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/tag_ceiling.png",
                                height: 22, fit: BoxFit.contain),
                            const SizedBox(width: 4),
                            Image.asset("assets/images/tag_repair.png",
                                height: 22, fit: BoxFit.contain),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text('서울시 성북구 안암로 145', style: AppTextStyles.b2),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: AppColors.grey3))),
                        ),
                        const SizedBox(height: 12),
                        Text('서비스 진행도', style: AppTextStyles.b2Bold),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                          child: Image.asset(AppAssets.serviceProgass1),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.coner2,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("2024년 12월 25일 방문 예정", style: AppTextStyles.b1BoldWhite),
                        ),
                        Text("의뢰서 보기", style: AppTextStyles.c1BoldWhite),
                        const Icon(
                          Icons.navigate_next_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
