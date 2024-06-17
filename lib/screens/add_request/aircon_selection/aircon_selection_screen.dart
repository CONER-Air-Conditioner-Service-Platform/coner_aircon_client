import 'package:coner_client/screens/add_request/aircon_selection/widgets/aircon_selection_widget.dart';
import 'package:coner_client/screens/add_request/aircon_selection/widgets/brand_selection_widget.dart';
import 'package:coner_client/screens/add_request/aircon_selection/widgets/service_selection_widget.dart';
import 'package:coner_client/screens/widgets/my_app_bar.dart';
import 'package:coner_client/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../configs/router/route_names.dart';
import '../../../provider/request_provider.dart';
import '../../../theme/app_decorations.dart';
import '../../../theme/app_size.dart';
import '../../../theme/app_text_styles.dart';

class AirconSelectionScreen extends StatefulWidget {
  const AirconSelectionScreen({super.key});

  @override
  State<AirconSelectionScreen> createState() => _AirconSelectionScreenState();
}

class _AirconSelectionScreenState extends State<AirconSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
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
                  Text("의뢰서 기본 정보", style: AppTextStyles.h2Bold),
                  Text("희망 서비스와 에어컨 종류를 선택해주세요.", style: AppTextStyles.b1),
                  const AddRequestServiceSelectionWidget(),
                  const AirconSelectionWidget(),
                  const BrandSelectionWidget(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          Container(
            height: 52,
            width: AppSize.ratioOfHorizontal(context, 1) - 24,
            margin: EdgeInsets.only(bottom: AppSize.getStatusBarHeight(context) + 20, top: 12),
            decoration: AppDecorations.gradientButtonDecoration,
            child: MaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                if (requestProvider.aircon == '') {
                  DialogUtil.basicDialog(context, "에어컨 종류를 선택해주세요.");
                  return;
                }
                if (requestProvider.airconBrand == '') {
                  DialogUtil.basicDialog(context, "브랜드를 선택해주세요.");
                  return;
                }
                context.pushNamed(RouteNames.additionalInformation);
              },
              child: Text('다음으로', style: AppTextStyles.s1BoldWhite),
            ),
          ),
        ],
      ),
    );
  }
}
