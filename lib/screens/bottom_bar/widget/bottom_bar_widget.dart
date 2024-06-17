import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/tabbar_provider.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    return Container(
      padding: const EdgeInsets.only(top: 4),
      height: 96,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.grey)],
      ),
      child: TabBar(
        controller: tabBarProvider.tabController,
        tabs: const [
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Tab(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ImageIcon(
                  AssetImage('assets/images/bottom_bar_item1.png'),
                ),
              ),
              text: "홈",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Tab(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ImageIcon(
                  AssetImage('assets/images/bottom_bar_item2.png'),
                ),
              ),
              text: "내 의뢰서",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Tab(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ImageIcon(
                  AssetImage('assets/images/bottom_bar_item3.png'),
                ),
              ),
              text: "마이페이지",
            ),
          ),
        ],
        labelColor: const Color(0xFF00E5FD), //Color(0xffe66a77)
        unselectedLabelColor: const Color(0xFFD9D9D9),
        indicatorColor: Colors.transparent,
        labelStyle: const TextStyle(fontSize: AppTextStyles.B2),
      ),
    );
  }
}
