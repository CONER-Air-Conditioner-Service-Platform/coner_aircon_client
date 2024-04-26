import 'package:coner_client/provider/request_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/request.dart';
import '../../../../../theme/app_assets.dart';
import '../../../../../theme/app_text_styles.dart';

class CompleteRequestList extends StatelessWidget {
  const CompleteRequestList({super.key});

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (requestProvider.requestHistoryList.length != 0) ...[
              for (Request request in requestProvider.requestHistoryList) ...[
                requestItem(request),
                const SizedBox(height: 8),
              ],
            ] else ...[
              Center(
                child: Text(
                  "아직 완료된 의뢰가 없어요!",
                  style: AppTextStyles.s1,
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget requestItem(Request request) {
    String serviceTag = '', airconTag = '';
    switch (request.aircon) {
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
    switch (request.service) {
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
              Text("${request.completeDate}", style: AppTextStyles.b2Grey),
              const SizedBox(width: 12),
              Text('${request.engineerName} 기사님', style: AppTextStyles.b2Grey),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Image.asset(airconTag, height: 22, fit: BoxFit.contain),
              const SizedBox(width: 4),
              Image.asset(serviceTag, height: 22, fit: BoxFit.contain),
              const SizedBox(width: 12),
              Expanded(
                child: Text('${request.address}', style: AppTextStyles.b2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
