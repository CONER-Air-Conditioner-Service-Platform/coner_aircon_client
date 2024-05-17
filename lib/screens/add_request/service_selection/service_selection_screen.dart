import 'package:coner_client/configs/router/route_names.dart';
import 'package:coner_client/screens/widgets/my_app_bar.dart';
import 'package:coner_client/utils/service_request_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../provider/request_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_size.dart';
import '../../../theme/app_text_styles.dart';

class ServiceSelectionScreen extends StatefulWidget {
  const ServiceSelectionScreen({super.key});

  @override
  State<ServiceSelectionScreen> createState() => _ServiceSelectionScreenState();
}

class _ServiceSelectionScreenState extends State<ServiceSelectionScreen> {
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
                  Text("서비스 유형 선택", style: AppTextStyles.h2Bold),
                  Text("어떤 서비스가 필요하신가요?", style: AppTextStyles.b1),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      for (int i = 0; i < serviceList.length; i++) ...[
                        GestureDetector(
                          onTap: () {
                            requestProvider.setService(serviceList[i]);
                            context.pushNamed(RouteNames.airconSelection);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.grey1, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  serviceImageList[i],
                                  fit: BoxFit.contain,
                                  width: (AppSize.ratioOfHorizontal(context, 1) - 240) / 3,
                                ),
                                const SizedBox(height: 20),
                                Text(serviceList[i], style: AppTextStyles.b1Bold),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
