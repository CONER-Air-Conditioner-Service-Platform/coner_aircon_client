import 'package:coner_client/screens/bottom_bar/pages/request/widget/request_progress.dart';
import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'complete_request_list.dart';

class RequestTabbar extends StatefulWidget {
  const RequestTabbar({super.key});

  @override
  State<RequestTabbar> createState() => _RequestTabbarState();
}

class _RequestTabbarState extends State<RequestTabbar> with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(
    length: 2,
    vsync: this,
    initialIndex: 0,
    animationDuration: const Duration(milliseconds: 100),
  );

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          _tabBarHelper(),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                RequestProgress(),
                CompleteRequestList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBarHelper() {
    return SizedBox(
      height: 52,
      child: TabBar(
        controller: tabController,
        tabs: const [Tab(text: "진행중인"), Tab(text: "완료된")],
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        labelStyle: AppTextStyles.b1BoldMain,
        unselectedLabelStyle: AppTextStyles.b1,
        indicatorColor: const Color(0xFF00E5FD),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.only(left: 20, right: 20),
      ),
    );
  }
}
