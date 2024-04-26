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

        for (DocumentSnapshot docSnapshot in snapshot.data!.docs) {
          Map<String, dynamic> data = docSnapshot.data()! as Map<String, dynamic>;
          if (docSnapshot.data() != null) {
            final request = Request.fromMap(data);
            requestProvider.setRequest(request);
          }
        }
        final tags = tagImageMapping(
          requestProvider.aircon,
          requestProvider.service,
          requestProvider.state,
          requestProvider.hopeDate,
        );
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
                                Image.asset(tags.$1, height: 22, fit: BoxFit.contain),
                                const SizedBox(width: 4),
                                Image.asset(tags.$2, height: 22, fit: BoxFit.contain),
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
      },
    );
  }
}
