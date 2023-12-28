import 'package:coner_client/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/font_styles.dart';

class RequestWidget extends StatefulWidget {
  const RequestWidget({super.key});

  @override
  State<RequestWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<RequestWidget> with SingleTickerProviderStateMixin {
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
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('의뢰하기', style: title1Bold),
          _requestTabBar(),
        ],
      ),
    );
  }

  Widget _requestTabBar() {
    return SizedBox(
      width: 200,
      child: TabBar(
        controller: tabController,
        tabs: const [
          Tab(text: "서비스 별"),
          Tab(text: "에어컨 별"),
        ],
        labelColor: conerColor2,
        labelStyle: title2Bold,
        unselectedLabelColor: conerGrey,
        unselectedLabelStyle: title2,
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
        indicatorColor: conerColor2,
        indicatorWeight: 3,
      ),
    );
  }
}
