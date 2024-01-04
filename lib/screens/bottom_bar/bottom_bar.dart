import 'package:coner_client/screens/bottom_bar/pages/home/home_page.dart';
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
            Center(child: Text("페이지3")),
          ],
        ),
        bottomNavigationBar: BottomBarWidget(),
      ),
    );
  }
}
