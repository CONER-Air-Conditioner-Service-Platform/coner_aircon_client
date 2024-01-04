import 'package:coner_client/screens/bottom_bar/pages/request/widget/request_appbar_widget.dart';
import 'package:coner_client/screens/bottom_bar/pages/request/widget/request_tabbar.dart';
import 'package:flutter/material.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RequestAppbarWidget(),
          RequestTabbar(),
        ],
      ),
    );
  }
}
