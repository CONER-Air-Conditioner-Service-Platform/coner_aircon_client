import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../provider/request_provider.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    return Container(
      margin: const EdgeInsets.all(20),
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
                      const Icon(Icons.calendar_today_outlined),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Text(
                              requestProvider.hopeDate == ''
                                  ? "희망 날짜 선택하기"
                                  : requestProvider.hopeDate,
                              style: AppTextStyles.b1Bold)),
                      const Icon(Icons.keyboard_arrow_up_rounded, size: 32),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SfDateRangePicker(
                  monthFormat: 'MMM',
                  headerStyle: DateRangePickerHeaderStyle(
                    backgroundColor: Colors.white,
                    textAlign: TextAlign.center,
                    textStyle: AppTextStyles.s1Bold,
                  ),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                    textStyle: AppTextStyles.b1,
                    todayTextStyle: AppTextStyles.b1,
                    disabledDatesTextStyle: AppTextStyles.b1Grey,
                  ),
                  selectionShape: DateRangePickerSelectionShape.rectangle,
                  view: DateRangePickerView.month,
                  showNavigationArrow: true,
                  allowViewNavigation: false,
                  backgroundColor: Colors.white,
                  initialSelectedDate: DateTime.now().add(const Duration(days: 7)),
                  minDate: DateTime.now().add(const Duration(days: 7)), //오늘 날짜 +1부터 시작일로 선택 가능
                  maxDate: DateTime.now().add(const Duration(days: 37)),
                  selectionMode: DateRangePickerSelectionMode.single,
                  selectionColor: AppColors.coner2,
                  selectionTextStyle: AppTextStyles.s1BoldWhite,
                  todayHighlightColor: AppColors.coner2,
                  showActionButtons: false,
                  confirmText: '선택하기',
                  onSelectionChanged: (args) =>
                      _convertDateTimeDisplay(args.value.toString(), context),
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
                  const Icon(Icons.calendar_today_outlined),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Text(
                          requestProvider.hopeDate == '' ? "희망 날짜 선택하기" : requestProvider.hopeDate,
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
