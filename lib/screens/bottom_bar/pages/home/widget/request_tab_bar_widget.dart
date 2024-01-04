import 'package:coner_client/configs/router/route_names.dart';
import 'package:coner_client/theme/colors.dart';
import 'package:coner_client/theme/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RequestTabBarWidget extends StatefulWidget {
  const RequestTabBarWidget({super.key});

  @override
  State<RequestTabBarWidget> createState() => _RequestTabBarWidgetState();
}

class _RequestTabBarWidgetState extends State<RequestTabBarWidget> {
  int selectedIndex = 0;
  List<String> serviceNameList = ['청소', '설치', '수리', '점검', '이전', '철거'];
  List<String> serviceImageList = [
    'assets/images/service_cleaning.png',
    'assets/images/service_build.png',
    'assets/images/service_repair.png',
    'assets/images/service_inspection.png',
    'assets/images/service_deliverytruck.png',
    'assets/images/service_broken.png',
  ];
  List<String> airconNameList = ['벽걸이형', '스탠드형', '천장형', '창문형', '냉난방기', '항온항습기', '2 in 1'];
  List<String> airconImageList = [
    'assets/images/aircon_wall.png',
    'assets/images/aircon_stand.png',
    'assets/images/aircon_ceiling.png',
    'assets/images/aircon_ceiling.png',
    'assets/images/aircon_conditioner.png',
    'assets/images/aircon_thermostat.png',
    'assets/images/aircon_thermostat.png',
  ];

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
              for (int i = 0; i < serviceNameList.length; i++) ...[
                if (i == 0) ...[const SizedBox(width: 20)],
                itemCard(serviceImageList[i], serviceNameList[i]),
                const SizedBox(width: 12),
              ]
            ] else ...[
              for (int i = 0; i < airconNameList.length; i++) ...[
                if (i == 0) ...[const SizedBox(width: 20)],
                itemCard(airconImageList[i], airconNameList[i]),
                const SizedBox(width: 12),
              ]
            ]
          ],
        ),
      );

  Widget itemCard(String image, String name) {
    return GestureDetector(
      onTap: () => context.pushNamed(RouteNames.addRequest),
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
            Expanded(flex: 3, child: Text(name, style: body2BoldWhite))
          ],
        ),
      ),
    );
  }
}
