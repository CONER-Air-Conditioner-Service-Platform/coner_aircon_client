import 'package:coner_client/theme/font_styles.dart';
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
          Text("아직 진행중인 의뢰가 없습니다!", style: body2),
          TextButton(
              onPressed: () => context.pushNamed(RouteNames.addRequest),
              child: Text("의뢰 하러가기", style: body1Button)),
        ],
      ),
    );
  }

  Widget submissionCompletedProgressHelper() {
    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("아직 진행중인 의뢰가 없습니다!", style: body2),
        ],
      ),
    );
  }
}
