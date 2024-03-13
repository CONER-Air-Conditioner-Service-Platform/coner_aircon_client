import 'package:coner_client/configs/router/route_names.dart';
import 'package:coner_client/theme/app_decorations.dart';
import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/client_provider.dart';

class MyProfileWidget extends StatelessWidget {
  const MyProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: AppDecorations.profileDecoration,
          width: 156,
          height: 156,
          child: Image.asset("assets/images/icon_white.png"),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${clientProvider.clientName == '' ? "방문자" : clientProvider.clientName} ',
                style: AppTextStyles.s1Bold),
            Text('님', style: AppTextStyles.s1),
          ],
        ),
        if (clientProvider.clientId == '') ...[
          TextButton(
            onPressed: () => context.goNamed(RouteNames.signIn),
            child: Text(
              "로그인 하러가기",
              style: AppTextStyles.b1BoldUnderline,
            ),
          ),
        ] else ...[
          const SizedBox(height: 4),
          Text(clientProvider.clientPhoneNumber, style: AppTextStyles.b2Grey),
          Text(clientProvider.clientAddress, style: AppTextStyles.b2Grey),
          Text(clientProvider.clientDetailAddress, style: AppTextStyles.b2Grey),
        ],
      ],
    );
  }
}
