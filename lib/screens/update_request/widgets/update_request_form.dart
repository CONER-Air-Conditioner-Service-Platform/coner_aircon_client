import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:coner_client/provider/request_provider.dart';
import 'package:coner_client/screens/add_request/widget/service_widget.dart';
import 'package:coner_client/screens/widgets/app_loading_widget.dart';
import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../provider/client_provider.dart';
import '../../../theme/app_decorations.dart';
import '../../../utils/dialog_util.dart';
import '../../../utils/service_request_util.dart';
import 'aircon_widget.dart';
import 'brand_widget.dart';
import 'calender_widget.dart';
import 'my_info_widget.dart';
import 'update_request_image_list_widget.dart';

class UpdateRequestForm extends StatefulWidget {
  UpdateRequestForm({super.key});

  @override
  State<UpdateRequestForm> createState() => _UpdateRequestFormState();
}

class _UpdateRequestFormState extends State<UpdateRequestForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController serviceDetailsController = TextEditingController();

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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final requestProvider = Provider.of<RequestProvider>(context, listen: false);
      requestProvider.offDataStream();
      serviceDetailsController = TextEditingController(text: requestProvider.detailInfo);
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
                const CalenderWidget(),
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
                        closedBorder: Border.all(width: 1, color: const Color(0xffA0A0A0)),
                        expandedBorder: Border.all(width: 1, color: const Color(0xffA0A0A0)),
                        closedBorderRadius: BorderRadius.circular(10),
                        expandedBorderRadius: BorderRadius.circular(10),
                        listItemStyle: AppTextStyles.b1,
                        hintStyle: AppTextStyles.b1Grey,
                      ),
                      hintText: "고장 증상 선택",
                      closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      items: failureSymptoms,
                      onChanged: (value) => requestProvider.setRepairMessage("$value\n"),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Text("추가적인 정보와 요청사항", style: AppTextStyles.s1Bold),
                const SizedBox(height: 8),
                _serviceDetailedHelper(),
                const SizedBox(height: 16),
                const UpdateRequestImageListWidget(),
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
                            bool isSuccess = await requestProvider.update(
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
      minLines: 6,
      maxLines: 6,
      controller: serviceDetailsController,
    );
  }
}