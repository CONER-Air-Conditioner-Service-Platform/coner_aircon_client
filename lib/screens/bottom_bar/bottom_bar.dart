import 'package:coner_client/screens/bottom_bar/pages/home/home_page.dart';
import 'package:coner_client/screens/bottom_bar/pages/my_page/my_page.dart';
import 'package:coner_client/screens/bottom_bar/pages/request/request_page.dart';
import 'package:coner_client/screens/bottom_bar/widget/bottom_bar_widget.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomePage(),
            RequestPage(),
            MyPage(),
          ],
        ),
        bottomNavigationBar: BottomBarWidget(),
      ),
    );
  }
}
