import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../provider/request_provider.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

class TimeWidget extends StatefulWidget {
  const TimeWidget({super.key});

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  List<String> timeArr = [
    "9:00 ~ 11:00",
    "11:00 ~ 13:00",
    "13:00 ~ 15:00",
    "15:00 ~ 17:00",
    "17:00 ~ 19:00",
  ];
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey1, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: isExpanded
          ? Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = false;
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.access_time_rounded),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Text(
                              requestProvider.hopeTime == ''
                                  ? "희망 시간대 선택하기"
                                  : requestProvider.hopeTime,
                              style: AppTextStyles.b1Bold)),
                      const Icon(Icons.keyboard_arrow_up_rounded, size: 32),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text("선택하신 시간대 사이에 기사님이 방문해요.", style: AppTextStyles.b2Grey),
                const SizedBox(height: 8),
                Wrap(
                  children: [
                    for (String time in timeArr) ...[
                      GestureDetector(
                        onTap: () => requestProvider.setHopeTime(time),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color:
                                requestProvider.hopeTime == time ? AppColors.coner2 : Colors.white,
                            border: Border.all(color: AppColors.grey1, width: 2),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            time,
                            style: requestProvider.hopeTime == time
                                ? AppTextStyles.b2BoldWhite
                                : AppTextStyles.b2Bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                )
              ],
            )
          : GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = true;
                });
              },
              child: Row(
                children: [
                  const Icon(Icons.access_time_rounded),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Text(
                          requestProvider.hopeTime == '' ? "희망 시간대 선택하기" : requestProvider.hopeTime,
                          style: AppTextStyles.b1Bold)),
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 32),
                ],
              ),
            ),
    );
  }

  // 캘린더에서 선택한 날짜를 포맷팅하고 컨트롤러에 넣어주는 메소드
  void _convertDateTimeDisplay(String date, BuildContext context) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    Provider.of<RequestProvider>(context, listen: false)
        .setHopeDate(serverFormater.format(displayDate));
  }
}
