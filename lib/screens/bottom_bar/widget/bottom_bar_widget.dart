import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/tabbar_provider.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    return Container(
      padding: const EdgeInsets.only(top: 5),
      height: 88,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.grey)],
      ),
      child: TabBar(
        controller: tabBarProvider.tabController,
        tabs: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Tab(icon: ImageIcon(AssetImage('assets/images/bottom_bar_item1.png'))),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Tab(icon: ImageIcon(AssetImage('assets/images/bottom_bar_item2.png'))),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Tab(icon: ImageIcon(AssetImage('assets/images/bottom_bar_item3.png'))),
          ),
        ],
        labelColor: Color(0xFF00E5FD), //Color(0xffe66a77)
        unselectedLabelColor: Color(0xFFD9D9D9),
        indicatorColor: Colors.transparent,
      ),
    );
  }
}
