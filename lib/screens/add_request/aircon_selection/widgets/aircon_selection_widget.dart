import 'package:coner_client/utils/service_request_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../provider/request_provider.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

class AirconSelectionWidget extends StatefulWidget {
  const AirconSelectionWidget({super.key});

  @override
  State<AirconSelectionWidget> createState() => _AirconSelectionWidgetState();
}

class _AirconSelectionWidgetState extends State<AirconSelectionWidget> {
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
                      const Icon(Icons.apps_rounded),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          requestProvider.aircon == '' ? "에어컨 종류 선택하기" : requestProvider.aircon,
                          style: AppTextStyles.b1Bold,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_up_rounded, size: 32),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  children: [
                    for (String aircon in airconList) ...[
                      GestureDetector(
                        onTap: () => requestProvider.setAircon(aircon),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color:
                                requestProvider.aircon == aircon ? AppColors.coner2 : Colors.white,
                            border: Border.all(color: AppColors.grey1, width: 2),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            aircon,
                            style: requestProvider.aircon == aircon
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
                  const Icon(Icons.apps_rounded),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      requestProvider.aircon == '' ? "에어컨 종류 선택하기" : requestProvider.aircon,
                      style: AppTextStyles.b1Bold,
                    ),
                  ),
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
