import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:coner_client/provider/request_provider.dart';
import 'package:coner_client/screens/addRequest/widget/service_widget.dart';
import 'package:coner_client/screens/widgets/app_loading_widget.dart';
import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../provider/client_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_decorations.dart';
import '../../../utils/dialog_util.dart';
import '../../../utils/service_request_util.dart';
import '../../../utils/toast_util.dart';
import 'aircon_widget.dart';
import 'brand_widget.dart';
import 'calender_widget.dart';
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
  TextEditingController serviceDetailsController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<RequestProvider>(context, listen: false).offDataStream();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    serviceDetailsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    final requestProvider = Provider.of<RequestProvider>(context);
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CalenderWidget(),
                AirconWidget(),
                ServiceWidget(),
                const BrandWidget(),
                const MyInfoWidget(),
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
                          onPressed: () async {
                            if (_formKey.currentState?.validate() != true) return;
                            if (clientProvider.clientId == '') {
                              DialogUtil.logInDialog(context);
                            }
                            AppLoadingWidget.loadingRequest(context, "의뢰서 등록중입니다.");
                            bool isSuccess = await requestProvider.add(
                              clientProvider.clientPhoneNumber,
                              clientProvider.clientAddress,
                              clientProvider.clientDetailAddress,
                              serviceDetailsController.text,
                              clientProvider.clientId,
                            );
                            Navigator.pop(context);
                            if (isSuccess) {
                              requestProvider.getDataStream(clientProvider.clientId);
                              context.pop();
                            } else {
                              ToastUtil.basic("의뢰서 등록을 실패하였습니다. 나중에 다시 시도해주세요.");
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
