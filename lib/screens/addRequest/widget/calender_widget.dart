import 'package:coner_client/view_models/request_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../theme/colors.dart';
import '../../../theme/font_styles.dart';
import '../../../theme/widget_size.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final displayRequest = Provider.of<RequestViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("방문 희망 예정일", style: title2Bold),
        Text("방문 희망 예정일은 신청일로부터 한 달 이후까지 가능합니다.", style: body2Grey),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            HapticFeedback.mediumImpact();
            _selectDataCalendar_Expecteddate_visit(context);
          },
          child: AbsorbPointer(
            child: TextFormField(
              autofocus: false,
              minLines: 1,
              maxLines: 2,
              enabled: true,
              decoration: InputDecoration(
                hintText: displayRequest.desiredServiceDate == ''
                    ? '클릭하여 날짜를 선택해주세요.'
                    : displayRequest.desiredServiceDate,
                hintStyle: body1,
                suffixIcon: const Icon(Icons.calendar_month),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  /// 캘린더를 띄우는 메소드
  void _selectDataCalendar_Expecteddate_visit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SizedBox(
            width: ratioOfVertical(context, 0.8),
            height: ratioOfHorizontal(context, 0.4),
            child: SfDateRangePicker(
              monthFormat: 'MMM',
              headerStyle:
                  DateRangePickerHeaderStyle(textAlign: TextAlign.center, textStyle: title1Bold),
              headerHeight: ratioOfVertical(context, 0.1),
              monthCellStyle: DateRangePickerMonthCellStyle(
                textStyle: title2,
                todayTextStyle: title2,
                disabledDatesTextStyle: title2Grey,
              ),
              selectionShape: DateRangePickerSelectionShape.rectangle,
              view: DateRangePickerView.month,
              showNavigationArrow: true,
              allowViewNavigation: false,
              backgroundColor: ThemeData.light().scaffoldBackgroundColor,
              initialSelectedDate: DateTime.now().add(const Duration(days: 1)),
              minDate: DateTime.now().add(const Duration(days: 1)), //오늘 날짜 +1부터 시작일로 선택 가능
              maxDate: DateTime.now().add(const Duration(days: 30)),
              selectionMode: DateRangePickerSelectionMode.single,
              selectionColor: conerColor2,
              selectionTextStyle: title2BoldWhite,
              todayHighlightColor: conerColor2,
              showActionButtons: true,
              confirmText: '선택하기',
              onSubmit: (args) => _convertDateTimeDisplay(args.toString(), context),
              cancelText: '취소',
              onCancel: () => Navigator.of(context).pop(),
            ),
          ),
        );
      },
    );
  }

  /// 캘린더에서 선택한 날짜를 포맷팅하고 컨트롤러에 넣어주는 메소드
  void _convertDateTimeDisplay(String date, BuildContext context) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    Provider.of<RequestViewModel>(context, listen: false)
        .setDesiredServiceDate(serverFormater.format(displayDate));
    Navigator.of(context).pop();
  }
}
