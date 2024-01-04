import 'package:coner_client/screens/bottom_bar/pages/home/widget/my_requests_widget.dart';
import 'package:coner_client/screens/bottom_bar/pages/home/widget/prograss_widget.dart';
import 'package:coner_client/screens/bottom_bar/pages/home/widget/request_widget.dart';
import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: conerBackgroundColor,
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrograssWidget(),
            SizedBox(height: 8),
            RequestWidget(),
            MyRequestsWidget(),
          ],
        ),
      ),
    );
  }
}
