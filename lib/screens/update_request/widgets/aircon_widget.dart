import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:coner_client/provider/request_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_text_styles.dart';
import '../../../utils/service_request_util.dart';

class AirconWidget extends StatefulWidget {
  AirconWidget({super.key});

  @override
  State<AirconWidget> createState() => _AirconWidgetState();
}

class _AirconWidgetState extends State<AirconWidget> {
  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("서비스 받을 에어컨", style: AppTextStyles.s1Bold),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: CustomDropdown(
                  decoration: CustomDropdownDecoration(
                    closedBorder: Border.all(width: 1, color: const Color(0xffA0A0A0)),
                    expandedBorder: Border.all(width: 1, color: const Color(0xffA0A0A0)),
                    closedBorderRadius: BorderRadius.circular(10),
                    expandedBorderRadius: BorderRadius.circular(10),
                    listItemStyle: AppTextStyles.b1,
                  ),
                  initialItem: requestProvider.aircon,
                  closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  items: airconList,
                  onChanged: (value) => requestProvider.setAircon(value),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 48,
                child: CustomDropdown(
                  decoration: CustomDropdownDecoration(
                    closedBorder: Border.all(width: 1, color: const Color(0xffA0A0A0)),
                    expandedBorder: Border.all(width: 1, color: const Color(0xffA0A0A0)),
                    closedBorderRadius: BorderRadius.circular(10),
                    expandedBorderRadius: BorderRadius.circular(10),
                    hintStyle: AppTextStyles.b1Grey,
                    listItemStyle: AppTextStyles.b1,
                  ),
                  initialItem: "${requestProvider.airconNum} 대",
                  closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  hintText: '0 대',
                  items: airconNumList,
                  onChanged: (value) {
                    String extractedNumber = value.substring(0, 1);
                    int number = int.parse(extractedNumber);
                    requestProvider.setAirconNum(number);
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
