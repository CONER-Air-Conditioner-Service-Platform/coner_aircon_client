import 'package:coner_client/screens/bottom_bar/pages/home/widget/blog_widget.dart';
import 'package:coner_client/screens/bottom_bar/pages/home/widget/home_app_bar_widget.dart';
import 'package:coner_client/screens/bottom_bar/pages/home/widget/my_requests_widget.dart';
import 'package:coner_client/screens/bottom_bar/pages/home/widget/service_info_widget.dart';
import 'package:coner_client/screens/bottom_bar/pages/home/widget/service_prograss_widget.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeAppbarWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ServicePrograssWidget(),
                  Container(
                    width: double.infinity,
                    height: 20,
                    color: AppColors.grey1,
                  ),
                  ServiceInfoWidget(),
                  Container(
                    width: double.infinity,
                    height: 20,
                    color: AppColors.grey1,
                  ),
                  BlogWidget(),
                  Container(
                    width: double.infinity,
                    height: 20,
                    color: AppColors.grey1,
                  ),
                  const MyRequestsWidget(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
