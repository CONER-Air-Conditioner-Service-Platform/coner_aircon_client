import 'package:coner_client/provider/client_provider.dart';
import 'package:coner_client/screens/add_request/additional_information/widgets/build_info_widget.dart';
import 'package:coner_client/screens/add_request/additional_information/widgets/detail_info_widget.dart';
import 'package:coner_client/screens/widgets/my_app_bar.dart';
import 'package:coner_client/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../configs/router/route_names.dart';
import '../../../models/service_item.dart';
import '../../../provider/request_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_decorations.dart';
import '../../../theme/app_size.dart';
import '../../../theme/app_text_styles.dart';
import 'widgets/add_request_image_list_widget.dart';

class AdditionalInformationScreen extends StatefulWidget {
  const AdditionalInformationScreen({super.key});

  @override
  State<AdditionalInformationScreen> createState() => _AdditionalInformationScreenState();
}

class _AdditionalInformationScreenState extends State<AdditionalInformationScreen> {
  final _formKey = GlobalKey<FormState>();
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
    final clientProvider = Provider.of<ClientProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyAppBar.noDecorations(context, () => context.pop()),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text("추가 요청사항", style: AppTextStyles.h2Bold),
                  Text("추가적으로 작성할 내용이 있나요?", style: AppTextStyles.b1),
                  if (requestProvider.service == "설치") ...[
                    const BuildInfoWidget(),
                  ] else if (requestProvider.service == "수리") ...[
                    const DetailInfoWidget(),
                  ],
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("요청사항", style: AppTextStyles.s1Bold),
                        const SizedBox(height: 8),
                        Form(key: _formKey, child: _serviceDetailedHelper()),
                        const SizedBox(height: 20),
                        const AddRequestImageListWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("서비스 기본 비용", style: AppTextStyles.s1Bold),
                        Text("견적을 위해 기사님이 방문한 후, 서비스를 취소하시면 아래 비용이 발생할 수 있어요.",
                            style: AppTextStyles.b2Grey),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.grey4,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(baseService[0].service_name, style: AppTextStyles.b1Bold),
                                  Expanded(
                                    child: Text(
                                      baseService[0].price,
                                      style: AppTextStyles.b1,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("(근무 외 시간 : 1.5배, 주말 : 2배)", style: AppTextStyles.b2)
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(baseService[1].service_name, style: AppTextStyles.b1Bold),
                                  Expanded(
                                    child: Text(
                                      baseService[1].price,
                                      style: AppTextStyles.b1,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          Container(
            height: 52,
            width: AppSize.ratioOfHorizontal(context, 1) - 24,
            margin: EdgeInsets.only(bottom: AppSize.getStatusBarHeight(context) + 20, top: 12),
            decoration: AppDecorations.gradientButtonDecoration,
            child: MaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if (requestProvider.service == "설치" && requestProvider.repairMessage == '') {
                  DialogUtil.basicDialog(context, "에어컨 보유 여부를 선택해주세요.");
                  return;
                }
                if (requestProvider.service == "수리" && requestProvider.repairMessage == '') {
                  DialogUtil.basicDialog(context, "고장 증상을 선택해주세요.");
                  return;
                }
                bool isSuccess = await requestProvider.add(
                  context,
                  clientProvider.clientPhoneNumber,
                  clientProvider.clientAddress,
                  clientProvider.clientDetailAddress,
                  serviceDetailsController.text,
                  clientProvider.clientId,
                );
                if (isSuccess) {
                  context.goNamed(RouteNames.main);
                }
              },
              child: Text('제출하기', style: AppTextStyles.s1BoldWhite),
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceDetailedHelper() {
    return TextFormField(
      autofocus: false,
      minLines: 5,
      maxLines: 5,
      controller: serviceDetailsController,
      decoration: InputDecoration(hintStyle: TextStyle(color: AppColors.grey2)),
    );
  }
}
