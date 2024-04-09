import 'package:coner_client/theme/app_colors.dart';
import 'package:coner_client/theme/app_size.dart';
import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../configs/router/route_names.dart';
import '../../../../../models/request.dart';
import '../../../../../provider/request_provider.dart';
import '../../../../../theme/app_assets.dart';
import '../../../../../theme/app_decorations.dart';
import '../../../../../utils/dialog_util.dart';
import '../../../../../utils/service_request_util.dart';

class RequestProgress extends StatelessWidget {
  RequestProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    return requestProvider.requestId == ''
        ? noProgress(context)
        : requestHelper(context, requestProvider);
  }

  Widget noProgress(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("아직 진행중인 의뢰가 없습니다!", style: AppTextStyles.b2),
          TextButton(
              onPressed: () => context.pushNamed(RouteNames.addRequest),
              child: Text("의뢰 하러가기", style: AppTextStyles.b1BoldUnderline)),
        ],
      ),
    );
  }

  Widget requestHelper(BuildContext context, RequestProvider requestProvider) {
    String servicePrograss = '';
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
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                child: Image.asset(servicePrograss),
              ),
              if (requestProvider.request.state == '서비스 진행중') ...[
                _engineerInfoHelper(context, requestProvider.request),
              ],
              const SizedBox(height: 8),
              Text("방문 희망 예정일", style: AppTextStyles.s1Bold),
              const SizedBox(height: 8),
              _infoHelper(requestProvider.hopeDate),
              const SizedBox(height: 16),
              Text("서비스 받을 에어컨", style: AppTextStyles.s1Bold),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _infoHelper(requestProvider.aircon)),
                  const SizedBox(width: 12),
                  Expanded(child: _infoHelper("${requestProvider.airconNum} 대")),
                ],
              ),
              const SizedBox(height: 16),
              Text("원하는 서비스", style: AppTextStyles.s1Bold),
              const SizedBox(height: 8),
              _infoHelper(requestProvider.service),
              const SizedBox(height: 16),
              Text("브랜드", style: AppTextStyles.s1Bold),
              const SizedBox(height: 8),
              _infoHelper(requestProvider.airconBrand),
              const SizedBox(height: 16),
              Text("주소", style: AppTextStyles.s1Bold),
              const SizedBox(height: 8),
              _infoHelper(requestProvider.request.address),
              const SizedBox(height: 8),
              _infoHelper(requestProvider.request.detailAddress),
              const SizedBox(height: 16),
              Text("연락처", style: AppTextStyles.s1Bold),
              const SizedBox(height: 8),
              _infoHelper(requestProvider.request.phone),
              const SizedBox(height: 16),
              Text("추가적인 정보와 요청사항", style: AppTextStyles.s1Bold),
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.topLeft,
                height: 160,
                padding: const EdgeInsets.only(left: 20, top: 12),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: const Color(0xffA0A0A0)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(requestProvider.detailInfo, style: AppTextStyles.b1),
              ),
              const SizedBox(height: 16),
              if (requestProvider.request.requestImageList.length > 0) ...[
                Text("추가 관련 사진", style: AppTextStyles.s1Bold),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (String requestImage in requestProvider.request.requestImageList) ...[
                        Image.network(requestImage, height: 120, fit: BoxFit.fitHeight),
                        const SizedBox(width: 8),
                      ],
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: Text("의뢰서 수정은 기사님 배정 전까지만 가능합니다.", style: AppTextStyles.b2),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: AppDecorations.buttonDecoration(Colors.redAccent),
                      child: MaterialButton(
                        height: 52,
                        minWidth: double.infinity,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () => DialogUtil.requestDeleteDialog(context, false),
                        child: Text('의뢰 삭제', style: AppTextStyles.b1BoldWhite),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: AppDecorations.buttonDecoration(const Color(0xffD9D9D9)),
                      child: MaterialButton(
                        height: 52,
                        minWidth: double.infinity,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () => context.pushNamed(RouteNames.updateRequest),
                        child: Text('수정하기', style: AppTextStyles.s1BoldWhite),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoHelper(String info) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 48,
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color(0xffA0A0A0)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(info, style: AppTextStyles.b1),
    );
  }

  Widget _engineerInfoHelper(BuildContext context, Request request) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text("배정된 기사님 정보", style: AppTextStyles.b1Bold),
          const SizedBox(height: 20),
          Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              color: AppColors.coner2,
              borderRadius: BorderRadius.circular(100),
            ),
            child: request.engineerProfileImage == null
                ? Image.asset(AppAssets.iconWhite)
                : CircleAvatar(
                    backgroundColor: AppColors.coner2,
                    radius: 100,
                    child: ClipOval(
                      child: Image.network(
                        request.engineerProfileImage!,
                        height: 128,
                        fit: BoxFit.fitHeight,
                        loadingBuilder:
                            (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(child: Image.asset(AppAssets.iconWhite));
                        },
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${request.engineerName} ", style: AppTextStyles.h2Bold),
              Text("기사님", style: AppTextStyles.h2),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.ratioOfHorizontal(context, 0.079)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.phone_android_rounded, color: AppColors.grey2),
                const SizedBox(width: 8),
                Container(
                    width: 120,
                    child: Text("${request.engineerPhone}", style: AppTextStyles.b2Bold)),
                GestureDetector(
                  onTap: () => launch("tel://${request.engineerPhone}"),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("전화 연결", style: AppTextStyles.c1BoldWhite),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.ratioOfHorizontal(context, 0.079)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.business_center_rounded, color: AppColors.grey2),
                const SizedBox(width: 8),
                Text("${request.companyName}", style: AppTextStyles.b2),
              ],
            ),
          ),
          Text("${request.companyAddress} ${request.companyDetailAddress}",
              style: AppTextStyles.c1Grey),
          const SizedBox(height: 28),
          Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              height: 76,
              decoration: BoxDecoration(
                color: AppColors.coner2,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("의뢰서 수락 날짜", style: AppTextStyles.c1BoldWhite),
                  Text("${request.acceptDate}", style: AppTextStyles.b1BoldWhite),
                ],
              ))
        ],
      ),
    );
  }
}
