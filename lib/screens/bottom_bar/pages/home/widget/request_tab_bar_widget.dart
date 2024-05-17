import 'package:coner_client/configs/router/route_names.dart';
import 'package:coner_client/provider/client_provider.dart';
import 'package:coner_client/provider/request_provider.dart';
import 'package:coner_client/theme/app_colors.dart';
import 'package:coner_client/theme/app_text_styles.dart';
import 'package:coner_client/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../database/firebase/request_firebase.dart';
import '../../../../../utils/service_request_util.dart';

class RequestTabBarWidget extends StatefulWidget {
  const RequestTabBarWidget({super.key});

  @override
  State<RequestTabBarWidget> createState() => _RequestTabBarWidgetState();
}

class _RequestTabBarWidgetState extends State<RequestTabBarWidget> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          customTabBar(),
          const SizedBox(height: 20),
          itemList(),
        ],
      ),
    );
  }

  Widget customTabBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          if (selectedIndex == 0) ...[
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.coner2, width: 4)),
              ),
              child: Text("서비스 별", style: AppTextStyles.s1BoldMain),
            ),
            SizedBox(width: 20),
            InkWell(
              onTap: () => setState(() => selectedIndex = 1),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.transparent, width: 4)),
                ),
                child: Text("에어컨 별", style: AppTextStyles.s1),
              ),
            )
          ] else ...[
            InkWell(
              onTap: () => setState(() => selectedIndex = 0),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.transparent, width: 4)),
                ),
                child: Text("서비스 별", style: AppTextStyles.s1),
              ),
            ),
            const SizedBox(width: 20),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.coner2, width: 4)),
              ),
              child: Text("에어컨 별", style: AppTextStyles.s1BoldMain),
            ),
          ]
        ],
      ),
    );
  }

  Widget itemList() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (selectedIndex == 0) ...[
              for (int i = 0; i < serviceList.length; i++) ...[
                if (i == 0) ...[const SizedBox(width: 20)],
                itemCard(serviceImageList[i], serviceList[i]),
                const SizedBox(width: 12),
              ]
            ] else ...[
              for (int i = 0; i < airconList.length; i++) ...[
                if (i == 0) ...[const SizedBox(width: 20)],
                itemCard(airconImageList[i], airconList[i]),
                const SizedBox(width: 12),
              ]
            ]
          ],
        ),
      );

  Widget itemCard(String image, String value) {
    final clientProvider = Provider.of<ClientProvider>(context, listen: false);
    return GestureDetector(
      onTap: () async {
        if (await RequestFirebase.getRequestProgressCount(clientProvider.clientId) > 0) {
          DialogUtil.basicDialog(context, "현재 진행중인 의뢰가 있습니다.\n의뢰는 최대 1개까지 진행 가능합니다.");
          return;
        }
        if (serviceList.contains(value)) {
          Provider.of<RequestProvider>(context, listen: false).setService(value);
        } else {
          Provider.of<RequestProvider>(context, listen: false).setAircon(value);
        }
        if (clientProvider.clientId.isEmpty) {
          DialogUtil.logInDialog(context);
        } else {
          context.pushNamed(RouteNames.clientInfo);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.coner1,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 109,
        height: 136,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 12, child: Image.asset(image, width: 62, fit: BoxFit.contain)),
            Expanded(flex: 4, child: Text(value, style: AppTextStyles.s1BoldWhite))
          ],
        ),
      ),
    );
  }
}
