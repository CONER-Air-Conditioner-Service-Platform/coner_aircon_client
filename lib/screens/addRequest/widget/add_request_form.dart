import 'package:coner_client/screens/addRequest/widget/service_widget.dart';
import 'package:coner_client/theme/colors.dart';
import 'package:coner_client/theme/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/decorations.dart';
import 'brand_widget.dart';
import 'calender_widget.dart';
import 'my_info_widget.dart';

class AddRequestForm extends StatefulWidget {
  AddRequestForm({super.key});

  @override
  State<AddRequestForm> createState() => _AddRequestFormState();
}

class _AddRequestFormState extends State<AddRequestForm> {
  final formKey = GlobalKey<FormState>();
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
    '경기 시흥시'
  ];

  TextEditingController serviceDetailsController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    serviceDetailsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CalenderWidget(),
              ServiceWidget(),
              const BrandWidget(),
              const MyInfoWidget(),
              Text("특이사항 및 세부사항", style: title2Bold),
              const SizedBox(height: 8),
              _serviceDetailedHelper(),
              const SizedBox(height: 40),
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("의뢰서 수정은 기사님 배정 전까지만 가능합니다.", style: body1),
                    Text("의뢰하시겠습니까?", style: body1Bold),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 54,
                      decoration: cancleButtonDecoration,
                      child: MaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () => context.pop(),
                        child: Text('취소', style: title2BoldWhite),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 7,
                    child: Container(
                      height: 54,
                      decoration: buttonDecoration,
                      child: MaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {},
                        child: Text('의뢰하기', style: title2BoldWhite),
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
    );
  }

  Widget _serviceDetailedHelper() {
    return TextFormField(
      autofocus: false,
      validator: (value) {
        if (value.toString().isEmpty) {
          return '특이사항 및 세부사항을 입력해주세요.';
        } else {
          return null;
        }
      },
      minLines: 8,
      maxLines: 8,
      controller: serviceDetailsController,
      decoration: InputDecoration(hintStyle: TextStyle(color: conerGrey)),
    );
  }
}
