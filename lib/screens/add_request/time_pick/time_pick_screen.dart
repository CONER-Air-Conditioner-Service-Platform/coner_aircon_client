import 'package:coner_client/screens/add_request/time_pick/widgets/calendar_widget.dart';
import 'package:coner_client/screens/add_request/time_pick/widgets/time_widget.dart';
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

class TimePickScreen extends StatefulWidget {
  const TimePickScreen({super.key});

  @override
  State<TimePickScreen> createState() => _TimePickScreenState();
}

class _TimePickScreenState extends State<TimePickScreen> {
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
                  Text("서비스 희망 날짜 선택", style: AppTextStyles.h2Bold),
                  Text("원하시는 서비스 날짜를 선택해주세요.", style: AppTextStyles.b1),
                  Text("오늘 날짜로부터 7일 이후부터 예약이 가능합니다. ", style: AppTextStyles.b2Grey),
                  const CalendarWidget(),
                  const TimeWidget(),
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
              onPressed: () {
                if (requestProvider.hopeDate == '') {
                  DialogUtil.basicDialog(context, "희망 날짜를 선택해주세요.");
                  return;
                }
                if (requestProvider.hopeTime == '') {
                  DialogUtil.basicDialog(context, "희망 시간대를 선택해주세요.");
                  return;
                }
                context.pushNamed(RouteNames.serviceSelection);
              },
              child: Text('다음으로', style: AppTextStyles.s1BoldWhite),
            ),
          ),
        ],
      ),
    );
  }
}
