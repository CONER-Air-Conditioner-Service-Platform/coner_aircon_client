import 'package:coner_client/utils/service_request_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/request_provider.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

class DetailInfoWidget extends StatefulWidget {
  const DetailInfoWidget({super.key});

  @override
  State<DetailInfoWidget> createState() => _DetailInfoWidgetState();
}

class _DetailInfoWidgetState extends State<DetailInfoWidget> {
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                      const Icon(Icons.comment_outlined),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          requestProvider.repairMessage == ''
                              ? "고장 증상 선택하기"
                              : requestProvider.repairMessage,
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
                    for (String failureSymptom in failureSymptoms) ...[
                      GestureDetector(
                        onTap: () => requestProvider.setRepairMessage(failureSymptom),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: requestProvider.repairMessage == failureSymptom
                                ? AppColors.coner2
                                : Colors.white,
                            border: Border.all(color: AppColors.grey1, width: 2),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            failureSymptom,
                            style: requestProvider.repairMessage == failureSymptom
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
                  const Icon(Icons.comment_outlined),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      requestProvider.repairMessage == ''
                          ? "고장 증상 선택하기"
                          : requestProvider.repairMessage,
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
