import 'package:coner_client/provider/client_provider.dart';
import 'package:coner_client/screens/add_request/additional_information/widgets/detail_info_widget.dart';
import 'package:coner_client/screens/widgets/my_app_bar.dart';
import 'package:coner_client/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../configs/router/route_names.dart';
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
                  if (requestProvider.service == "수리") ...[
                    const DetailInfoWidget(),
                  ],
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
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
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          Container(
            height: 52,
            width: AppSize.ratioOfHorizontal(context, 1) - 40,
            margin: EdgeInsets.only(bottom: AppSize.getStatusBarHeight(context) + 20, top: 12),
            decoration: AppDecorations.gradientButtonDecoration,
            child: MaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () async {
                FocusScope.of(context).unfocus();

                if (_formKey.currentState?.validate() != true) return;

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
