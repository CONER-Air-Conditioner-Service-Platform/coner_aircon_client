import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/request_provider.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/service_request_util.dart';

class BrandWidget extends StatelessWidget {
  const BrandWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("브랜드", style: AppTextStyles.s1Bold),
        const SizedBox(height: 8),
        SizedBox(
          height: 48,
          child: CustomDropdown.search(
            decoration: CustomDropdownDecoration(
              closedBorder: Border.all(width: 1, color: const Color(0xffA0A0A0)),
              expandedBorder: Border.all(width: 1, color: const Color(0xffA0A0A0)),
              closedBorderRadius: BorderRadius.circular(10),
              expandedBorderRadius: BorderRadius.circular(10),
              hintStyle: AppTextStyles.b1Grey,
              listItemStyle: AppTextStyles.b1,
            ),
            initialItem: requestProvider.airconBrand,
            hintText: "브랜드 선택",
            closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            items: brandList,
            onChanged: (value) => requestProvider.setAirconBrand(value),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
