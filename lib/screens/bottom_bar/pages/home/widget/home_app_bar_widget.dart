import 'package:coner_client/provider/client_provider.dart';
import 'package:coner_client/theme/app_assets.dart';
import 'package:coner_client/theme/app_decorations.dart';
import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../theme/app_size.dart';

class HomeAppbarWidget extends StatelessWidget {
  const HomeAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    return Container(
      padding: EdgeInsets.only(
          top: AppSize.getStatusBarHeight(context) + 20, bottom: 10, left: 20, right: 20),
      decoration: AppDecorations.bottomRadiusDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(AppAssets.logoColor, height: 32, fit: BoxFit.contain),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${clientProvider.clientName == '' ? "방문자" : clientProvider.clientName} ',
                  style: AppTextStyles.s1Bold),
              Text('님', style: AppTextStyles.s1),
            ],
          ),
        ],
      ),
    );
  }
}
