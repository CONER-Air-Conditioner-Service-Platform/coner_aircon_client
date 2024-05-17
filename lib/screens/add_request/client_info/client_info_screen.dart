import 'package:coner_client/provider/client_provider.dart';
import 'package:coner_client/screens/add_request/client_info/widgets/my_info_widget.dart';
import 'package:coner_client/screens/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../configs/router/route_names.dart';
import '../../../theme/app_decorations.dart';
import '../../../theme/app_size.dart';
import '../../../theme/app_text_styles.dart';

class ClientInfoScreen extends StatefulWidget {
  const ClientInfoScreen({super.key});

  @override
  State<ClientInfoScreen> createState() => _ClientInfoScreenState();
}

class _ClientInfoScreenState extends State<ClientInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyAppBar.noDecorations(context, () => context.pop()),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text("다시 한번 확인해주세요!", style: AppTextStyles.h2Bold),
                  Text("기사님께 제공할 주소와 연락처가 맞나요?", style: AppTextStyles.b1),
                  const Padding(padding: EdgeInsets.all(20), child: MyInfoWidget()),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          Container(
            height: 52,
            width: AppSize.ratioOfHorizontal(context, 1) - 40,
            margin: EdgeInsets.only(bottom: AppSize.getStatusBarHeight(context) + 20, top: 12),
            decoration: AppDecorations.gradientButtonDecoration,
            child: MaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () async {
                if (clientProvider.checkRegion()) {
                  context.pushNamed(RouteNames.timePick);
                } else {
                  context.pushNamed(RouteNames.regionRestrictionNotice);
                }
              },
              child: Text('의뢰 시작하기', style: AppTextStyles.s1BoldWhite),
            ),
          ),
        ],
      ),
    );
  }
}
