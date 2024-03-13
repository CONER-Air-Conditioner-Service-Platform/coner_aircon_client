import 'package:coner_client/screens/bottom_bar/pages/home/widget/home_app_bar_widget.dart';
import 'package:coner_client/screens/bottom_bar/pages/home/widget/my_requests_widget.dart';
import 'package:coner_client/screens/bottom_bar/pages/home/widget/request_widget.dart';
import 'package:coner_client/screens/bottom_bar/pages/home/widget/service_prograss_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/client_provider.dart';
import '../../../../theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.grey1,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeAppbarWidget(),
            const ServicePrograssWidget(),
            const RequestWidget(),
            if (clientProvider.clientId != '') ...[
              const MyRequestsWidget(),
            ],
          ],
        ),
      ),
    );
  }
}
