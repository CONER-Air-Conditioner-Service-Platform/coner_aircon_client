import 'package:coner_client/screens/bottom_bar/screens/home/widget/prograss_widget.dart';
import 'package:coner_client/screens/bottom_bar/screens/home/widget/request_widget.dart';
import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: conerBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrograssWidget(),
          SizedBox(height: 10),
          RequestWidget(),
        ],
      ),
    );
  }
}
