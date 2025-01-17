import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coner_client/theme/app_colors.dart';
import 'package:coner_client/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../configs/router/route_names.dart';
import '../../../../../models/request.dart';
import '../../../../../provider/client_provider.dart';
import '../../../../../provider/request_provider.dart';
import '../../../../../provider/tabbar_provider.dart';
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
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    final clientProvider = Provider.of<ClientProvider>(context);
    if (clientProvider.clientId == '') {
      return Container(
        margin: const EdgeInsets.all(20),
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
      );
    }
    Stream<QuerySnapshot> requestStream = FirebaseFirestore.instance
        .collection("requests")
        .where("clientId", isEqualTo: clientProvider.clientId)
        .where("state", whereIn: ["서비스 진행중", "서비스 대기중"]).snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: requestStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          DialogUtil.basicDialog(context, "데이터를 가져오지 못했어요.\n앱을 껐다가 다시 켜주세요.");
          return const SizedBox();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }

        List<Request> requests = [];
        for (DocumentSnapshot docSnapshot in snapshot.data!.docs) {
          Map<String, dynamic> data = docSnapshot.data()! as Map<String, dynamic>;
          if (docSnapshot.data() != null) {
            requests.add(Request.fromMap(data));
          }
        }
        if (requests.isEmpty) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: GestureDetector(
              onTap: () {
                context.pushNamed(RouteNames.profileUpdate);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    color: AppColors.grey4,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "${clientProvider.clientAddress} ${clientProvider.clientDetailAddress}",
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.navigate_next_rounded,
                          size: 24,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text("서비스 예약하기", style: AppTextStyles.h2Bold),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (int i = 0; i < serviceList.length; i++) ...[
                            serviceMenuItem(
                              serviceImageList[i],
                              serviceList[i],
                              () {
                                Provider.of<RequestProvider>(context, listen: false)
                                    .setService(serviceList[i]);
                                context.goNamed(RouteNames.clientInfo);
                              },
                            ),
                          ]
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        }
        final tags = tagImageMapping(
          requests[0].aircon,
          requests[0].service,
          requests[0].state,
          requests[0].hopeDate,
        );
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('내 의뢰 현황', style: AppTextStyles.h2Bold),
              const SizedBox(height: 12),
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
                              Image.asset(tags.$1, height: 22, fit: BoxFit.contain),
                              const SizedBox(width: 4),
                              Image.asset(tags.$2, height: 22, fit: BoxFit.contain),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text("${requests[0].address} ${requests[0].detailAddress}",
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
                            child: Image.asset(tags.$3),
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
                            child: Text("${requests[0].hopeDate} 방문 예정",
                                style: AppTextStyles.b1BoldWhite),
                          ),
                          GestureDetector(
                              onTap: () => tabBarProvider.setIndex(1),
                              child: Text("의뢰서 보기", style: AppTextStyles.b2BoldWhite)),
                          const Icon(Icons.navigate_next_rounded, size: 20, color: Colors.white),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget serviceMenuItem(String image, String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(image, width: 36, fit: BoxFit.contain),
          const SizedBox(height: 8),
          Text(title, style: AppTextStyles.b1),
        ],
      ),
    );
  }
}
