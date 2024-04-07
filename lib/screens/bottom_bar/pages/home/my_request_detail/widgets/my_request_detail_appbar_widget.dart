import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../../provider/client_provider.dart';
import '../../../../../../theme/app_decorations.dart';
import '../../../../../../theme/app_size.dart';
import '../../../../../../theme/app_text_styles.dart';

class MyRequestDetailAppbarWidget extends StatelessWidget {
  const MyRequestDetailAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    return Container(
      padding: EdgeInsets.only(
          top: AppSize.getStatusBarHeight(context) + 28, bottom: 12, left: 20, right: 20),
      decoration: AppDecorations.bottomRadiusDecoration,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(CupertinoIcons.back, size: 24),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${clientProvider.clientName == '' ? "방문자 님" : clientProvider.clientName} 님',
                    style: AppTextStyles.s1Bold),
                Text('의 의뢰서', style: AppTextStyles.s1),
              ],
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}
