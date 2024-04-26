import 'package:coner_client/provider/client_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../theme/app_decorations.dart';
import '../../../../../theme/app_text_styles.dart';
import '../../../provider/request_provider.dart';
import '../../../theme/app_size.dart';

class UpdateRequestAppbarWidget extends StatelessWidget {
  const UpdateRequestAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    return Container(
      padding: EdgeInsets.only(top: AppSize.getStatusBarHeight(context) + 12, left: 12, right: 20),
      decoration: AppDecorations.bottomRadiusDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: IconButton(
              onPressed: () {
                final requestProvider = Provider.of<RequestProvider>(context, listen: false);
                requestProvider.clearRequestImage();
                context.pop();
              },
              icon: const Icon(CupertinoIcons.back, size: 24),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${clientProvider.clientName == '' ? '방문자' : clientProvider.clientName} 님',
                      style: AppTextStyles.s1Bold),
                  Text('의 의뢰서', style: AppTextStyles.s1),
                ],
              ),
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}
