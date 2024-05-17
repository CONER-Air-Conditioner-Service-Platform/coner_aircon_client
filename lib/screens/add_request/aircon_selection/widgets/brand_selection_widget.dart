import 'package:coner_client/utils/service_request_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../provider/request_provider.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

class BrandSelectionWidget extends StatefulWidget {
  const BrandSelectionWidget({super.key});

  @override
  State<BrandSelectionWidget> createState() => _BrandSelectionWidgetState();
}

class _BrandSelectionWidgetState extends State<BrandSelectionWidget> {
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
                      const Icon(Icons.business_center_outlined),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          requestProvider.airconBrand == ''
                              ? "브랜드 선택하기"
                              : requestProvider.airconBrand,
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
                    for (String brand in brandList) ...[
                      GestureDetector(
                        onTap: () => requestProvider.setAirconBrand(brand),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: requestProvider.airconBrand == brand
                                ? AppColors.coner2
                                : Colors.white,
                            border: Border.all(color: AppColors.grey1, width: 2),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            brand,
                            style: requestProvider.airconBrand == brand
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
                  const Icon(Icons.business_center_outlined),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      requestProvider.airconBrand == '' ? "브랜드 선택하기" : requestProvider.airconBrand,
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
