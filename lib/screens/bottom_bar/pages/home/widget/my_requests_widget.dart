import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coner_client/models/request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/client_provider.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_text_styles.dart';
import '../../../../../utils/dialog_util.dart';
import '../../../../../utils/service_request_util.dart';

class MyRequestsWidget extends StatelessWidget {
  const MyRequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    Stream<QuerySnapshot> requestStream = FirebaseFirestore.instance
        .collection("requests")
        .where("clientId", isEqualTo: clientProvider.clientId)
        .where("state", isEqualTo: "서비스 완료")
        .orderBy("completeDate", descending: true)
        .snapshots();
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
          return Container(
            color: AppColors.grey1,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (requests.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15, top: 4),
                          child: Text('최근 내 의뢰', style: AppTextStyles.h2Bold),
                        ),
                      ],
                      for (Request request in requests) ...[
                        _requestItem(request),
                        const SizedBox(height: 8),
                      ]
                    ]),
              ),
            ),
          );
        });
  }

  Widget _requestItem(Request request) {
    (String, String, String) images =
        tagImageMapping(request.aircon, request.service, request.state, request.hopeDate);
    return Container(
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
              Text('${request.completeDate}', style: AppTextStyles.b2Grey),
              const SizedBox(width: 12),
              Text('${request.engineerName} 기사님', style: AppTextStyles.b2Grey),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Image.asset(images.$1, height: 22, fit: BoxFit.contain),
              const SizedBox(width: 4),
              Image.asset(images.$2, height: 22, fit: BoxFit.contain),
              const SizedBox(width: 12),
              Expanded(
                child: Text(request.address, style: AppTextStyles.b2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
