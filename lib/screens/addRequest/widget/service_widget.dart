import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:coner_client/provider/request_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_text_styles.dart';
import '../../../utils/service_request_util.dart';

class ServiceWidget extends StatefulWidget {
  ServiceWidget({super.key});

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("원하는 서비스", style: AppTextStyles.s1Bold),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: CustomDropdown(
                  decoration: CustomDropdownDecoration(
                    closedBorder: const Border(
                      right: BorderSide(width: 1, color: Color(0xffA0A0A0)),
                      left: BorderSide(width: 1, color: Color(0xffA0A0A0)),
                      top: BorderSide(width: 1, color: Color(0xffA0A0A0)),
                    ),
                    expandedBorder: Border.all(width: 1, color: const Color(0xffA0A0A0)),
                    closedBorderRadius: BorderRadius.circular(10),
                    expandedBorderRadius: BorderRadius.circular(10),
                    listItemStyle: AppTextStyles.b1,
                  ),
                  initialItem: requestProvider.service,
                  closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  items: serviceList,
                  onChanged: (value) => requestProvider.setService(value),
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
