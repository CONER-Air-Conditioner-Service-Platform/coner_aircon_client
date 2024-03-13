import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../configs/router/route_names.dart';
import '../../../../../theme/app_decorations.dart';

class ServiceMenuWidget extends StatelessWidget {
  const ServiceMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 28),
      decoration: AppDecorations.buttonDecoration(Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
              onPressed: () => context.pushNamed(RouteNames.profileUpdate),
              child: Text('내 정보 수정', style: AppTextStyles.b1)),
        ],
      ),
    );
  }
}
