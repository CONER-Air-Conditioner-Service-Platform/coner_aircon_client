import 'package:coner_client/configs/router/route_names.dart';
import 'package:coner_client/theme/colors.dart';
import 'package:coner_client/theme/font_styles.dart';
import 'package:coner_client/view_models/request_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
                border: Border(bottom: BorderSide(color: conerColor2, width: 4)),
              ),
              child: Text("서비스 별", style: title2BoldMainColor),
            ),
            SizedBox(width: 20),
            InkWell(
              onTap: () => setState(() => selectedIndex = 1),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.transparent, width: 4)),
                ),
                child: Text("에어컨 별", style: title2),
              ),
            )
          ] else ...[
            InkWell(
              onTap: () => setState(() => selectedIndex = 0),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.transparent, width: 4)),
                ),
                child: Text("서비스 별", style: title2),
              ),
            ),
            const SizedBox(width: 20),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: conerColor2, width: 4)),
              ),
              child: Text("에어컨 별", style: title2BoldMainColor),
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
    return GestureDetector(
      onTap: () {
        if (serviceList.contains(value)) {
          Provider.of<RequestViewModel>(context, listen: false).setServiceType(value);
        } else {
          Provider.of<RequestViewModel>(context, listen: false).setAirconType(value);
        }
        context.pushNamed(RouteNames.addRequest);
      },
      child: Container(
        decoration: BoxDecoration(
          color: conerColor2,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 120,
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 13, child: Image.asset(image, width: 90, fit: BoxFit.contain)),
            Expanded(flex: 3, child: Text(value, style: body2BoldWhite))
          ],
        ),
      ),
    );
  }
}
