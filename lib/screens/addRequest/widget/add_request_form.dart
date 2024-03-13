import 'package:coner_client/screens/addRequest/widget/service_widget.dart';
import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../provider/client_provider.dart';
import '../../../theme/app_decorations.dart';
import '../../../utils/dialog_util.dart';
import 'aircon_widget.dart';
import 'brand_widget.dart';
import 'calender_widget.dart';
import 'detailed_widget.dart';
import 'my_info_widget.dart';

class AddRequestForm extends StatefulWidget {
  AddRequestForm({super.key});

  @override
  State<AddRequestForm> createState() => _AddRequestFormState();
}

class _AddRequestFormState extends State<AddRequestForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> scopeOfServiceLocation = [
    '서울 도봉구',
    '서울 동대문구',
    '서울 은평구',
    '서울 강북구',
    '서울 관악구',
    '서울 광진구',
    '서울 종로구',
    '서울 중랑구',
    '서울 노원구',
    '서울 성북구',
  ];

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CalenderWidget(),
                AirconWidget(),
                ServiceWidget(),
                const BrandWidget(),
                const MyInfoWidget(),
                const DetailedWidget(),
                const SizedBox(height: 40),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("의뢰서 수정은 기사님 배정 전까지만 가능합니다.", style: AppTextStyles.b2),
                      Text("의뢰하시겠습니까?", style: AppTextStyles.b2Bold),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 52,
                        decoration: AppDecorations.buttonDecoration(const Color(0xffD9D9D9)),
                        child: MaterialButton(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onPressed: () => context.pop(),
                          child: Text('취소', style: AppTextStyles.s1BoldWhite),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 7,
                      child: Container(
                        height: 52,
                        decoration: AppDecorations.gradientButtonDecoration,
                        child: MaterialButton(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {
                            if (_formKey.currentState?.validate() != true) return;
                            if (clientProvider.clientId == '') {
                              DialogUtil.logInDialog(context);
                            }
                          },
                          child: Text('의뢰하기', style: AppTextStyles.s1BoldWhite),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
