import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../configs/router/route_names.dart';

class RequestProgress extends StatelessWidget {
  RequestProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return noProgress(context);
  }

  Widget noProgress(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("아직 진행중인 의뢰가 없습니다!", style: AppTextStyles.b2),
          TextButton(
              onPressed: () => context.pushNamed(RouteNames.addRequest),
              child: Text("의뢰 하러가기", style: AppTextStyles.b1BoldUnderline)),
        ],
      ),
    );
  }
}
