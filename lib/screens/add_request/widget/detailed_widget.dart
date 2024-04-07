import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:coner_client/provider/request_provider.dart';
import 'package:coner_client/utils/service_request_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class DetailedWidget extends StatefulWidget {
  const DetailedWidget({super.key});

  @override
  State<DetailedWidget> createState() => _DetailedWidgetState();
}

class _DetailedWidgetState extends State<DetailedWidget> {
  TextEditingController serviceDetailsController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    serviceDetailsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (requestProvider.service == "수리") ...[
          Text("고장 증상", style: AppTextStyles.s1Bold),
          const SizedBox(height: 8),
          SizedBox(
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
                hintStyle: AppTextStyles.b1Grey,
              ),
              hintText: "고장 증상 선택",
              closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              items: failureSymptoms,
              onChanged: (value) => requestProvider.setDetailInfo("$value\n"),
            ),
          ),
          const SizedBox(height: 16),
        ],
        Text("추가적인 정보와 요청사항", style: AppTextStyles.s1Bold),
        const SizedBox(height: 8),
        _serviceDetailedHelper(),
      ],
    );
  }

  Widget _serviceDetailedHelper() {
    return TextFormField(
      autofocus: false,
      validator: (value) {
        if (value.toString().isEmpty) {
          return '추가적인 정보와 요청사항을 입력해주세요.';
        } else {
          return null;
        }
      },
      minLines: 5,
      maxLines: 5,
      controller: serviceDetailsController,
      decoration: InputDecoration(hintStyle: TextStyle(color: AppColors.grey2)),
    );
  }
}
