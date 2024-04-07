import 'package:coner_client/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../configs/router/route_names.dart';
import '../../../../../provider/client_provider.dart';
import '../../../../../provider/request_provider.dart';
import '../../../../../theme/app_assets.dart';
import '../../../../../theme/app_text_styles.dart';
import '../../../../../utils/service_request_util.dart';

class ServicePrograssWidget extends StatefulWidget {
  const ServicePrograssWidget({super.key});

  @override
  State<ServicePrograssWidget> createState() => _ServicePrograssWidgetState();
}

class _ServicePrograssWidgetState extends State<ServicePrograssWidget> {
  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    final requestProvider = Provider.of<RequestProvider>(context);
    String serviceTag = '', airconTag = '', servicePrograss = '';
    switch (requestProvider.aircon) {
      case "벽걸이형":
        airconTag = AppAssets.tagWall;
        break;
      case "천장형":
        airconTag = AppAssets.tagCeiling;
        break;
      case "항온항습기":
        airconTag = AppAssets.tagThermostat;
        break;
      case "창문형":
        airconTag = AppAssets.tagWindow;
        break;
      case "스탠드형":
        airconTag = AppAssets.tagStand;
        break;
    }
    switch (requestProvider.service) {
      case "청소":
        serviceTag = AppAssets.tagClean;
        break;
      case "설치":
        serviceTag = AppAssets.tagInstallation;
        break;
      case "수리":
        serviceTag = AppAssets.tagRepair;
        break;
      case "점검":
        serviceTag = AppAssets.tagInspection;
        break;
      case "이전":
        serviceTag = AppAssets.tagRelocation;
        break;
      case "철거":
        serviceTag = AppAssets.tagRemoval;
        break;
    }
    switch (requestProvider.request.state) {
      case "서비스 대기중":
        servicePrograss = AppAssets.serviceProgass1;
        break;
      case "서비스 진행중":
        if (requestProvider.request.hopeDate == getToday()) {
          servicePrograss = AppAssets.serviceProgass3;
        } else {
          servicePrograss = AppAssets.serviceProgass2;
        }
        break;
    }
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
              ),
            ),
          ] else if (requestProvider.requestId == '') ...[
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
                  Text("현재 진행중인 서비스가 없습니다.", style: AppTextStyles.b1),
                  TextButton(
                    onPressed: () => context.goNamed(RouteNames.addRequest),
                    child: Text(
                      "의뢰하러가기",
                      style: AppTextStyles.b1BoldUnderline,
                    ),
                  ),
                ],
              ),
            ),
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
                            Image.asset(airconTag, height: 22, fit: BoxFit.contain),
                            const SizedBox(width: 4),
                            Image.asset(serviceTag, height: 22, fit: BoxFit.contain),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                  "${requestProvider.request.address} ${requestProvider.request.detailAddress}",
                                  style: AppTextStyles.b2),
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
                          child: Image.asset(servicePrograss),
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
                          child: Text("${requestProvider.hopeDate} 방문 예정",
                              style: AppTextStyles.b1BoldWhite),
                        ),
                        GestureDetector(
                            onTap: () {
                              context.pushNamed(RouteNames.myRequestDetail);
                            },
                            child: Text("의뢰서 보기", style: AppTextStyles.c1BoldWhite)),
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
