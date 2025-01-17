import 'package:coner_client/screens/bottom_bar/pages/home/home_page.dart';
import 'package:coner_client/screens/bottom_bar/pages/my_page/my_page.dart';
import 'package:coner_client/screens/bottom_bar/pages/request/request_page.dart';
import 'package:coner_client/screens/bottom_bar/widget/bottom_bar_widget.dart';
import 'package:coner_client/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/client_provider.dart';
import '../../provider/request_provider.dart';
import '../../provider/tabbar_provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(
    length: 3,
    vsync: this,
    animationDuration: const Duration(milliseconds: 100),
  );

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final clientProvider = Provider.of<ClientProvider>(context, listen: false);
      final requestProvider = Provider.of<RequestProvider>(context, listen: false);
      requestProvider.getData(clientProvider.clientId);
      //requestProvider.getDataStream(clientProvider.clientId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    tabBarProvider.setController(tabController);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomePage(),
            RequestPage(),
            MyPage(),
          ],
        ),
        bottomNavigationBar: const BottomBarWidget(),
      ),
    );
  }
}
