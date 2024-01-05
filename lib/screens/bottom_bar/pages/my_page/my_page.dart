import 'package:coner_client/screens/bottom_bar/pages/my_page/widget/client_menu_widget.dart';
import 'package:coner_client/screens/bottom_bar/pages/my_page/widget/my_page_appbar_widget.dart';
import 'package:coner_client/screens/bottom_bar/pages/my_page/widget/my_profile_widget.dart';
import 'package:coner_client/screens/bottom_bar/pages/my_page/widget/system_menu_widget.dart';
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      body: Column(
        children: [
          MyPageAppbarWidget(),
          SizedBox(height: 56),
          MyProfileWidget(),
          ClientMenuWidget(),
          SystemMenuWidget(),
        ],
      ),
    );
  }
}
