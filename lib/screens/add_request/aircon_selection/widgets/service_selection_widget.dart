import 'package:coner_client/utils/service_request_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/request_provider.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

class AddRequestServiceSelectionWidget extends StatefulWidget {
  const AddRequestServiceSelectionWidget({super.key});

  @override
  State<AddRequestServiceSelectionWidget> createState() => _AddRequestServiceSelectionWidgetState();
}

class _AddRequestServiceSelectionWidgetState extends State<AddRequestServiceSelectionWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 20),
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
                      const Icon(Icons.engineering_outlined),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          requestProvider.service == '' ? "서비스 선택하기" : requestProvider.service,
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
                    for (String service in serviceList) ...[
                      GestureDetector(
                        onTap: () => requestProvider.setService(service),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: requestProvider.service == service
                                ? AppColors.coner2
                                : Colors.white,
                            border: Border.all(color: AppColors.grey1, width: 2),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            service,
                            style: requestProvider.service == service
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
                  const Icon(Icons.engineering_outlined),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      requestProvider.service == '' ? "서비스 선택하기" : requestProvider.service,
                      style: AppTextStyles.b1Bold,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 32),
                ],
              ),
            ),
    );
  }
}
