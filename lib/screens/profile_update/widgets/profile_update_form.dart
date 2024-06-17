import 'package:coner_client/provider/client_provider.dart';
import 'package:coner_client/theme/app_colors.dart';
import 'package:coner_client/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../configs/router/route_names.dart';
import '../../../theme/app_decorations.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/toast_util.dart';
import '../../widgets/app_loading_widget.dart';
import '../../widgets/app_text_fields.dart';

class ProfileUpdateForm extends StatefulWidget {
  const ProfileUpdateForm({super.key});

  @override
  State<ProfileUpdateForm> createState() => _ProfileUpdateFormState();
}

class _ProfileUpdateFormState extends State<ProfileUpdateForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController controllerPhoneNumber;
  late TextEditingController controllerVerificationCode = TextEditingController();
  late TextEditingController controllerName;
  late TextEditingController controllerAddress;
  late TextEditingController controllerDetailAddress;
  @override
  void initState() {
    super.initState();
    final clientProvider = Provider.of<ClientProvider>(context, listen: false);
    controllerPhoneNumber = TextEditingController(text: clientProvider.clientPhoneNumber);
    controllerName = TextEditingController(text: clientProvider.clientName);
    controllerAddress = TextEditingController(text: clientProvider.clientAddress);
    controllerDetailAddress = TextEditingController(text: clientProvider.clientDetailAddress);
  }

  @override
  void dispose() {
    controllerPhoneNumber.dispose();
    controllerVerificationCode.dispose();
    controllerName.dispose();
    controllerAddress.dispose();
    controllerDetailAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('전화번호 변경', style: AppTextStyles.s1Bold),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(left: 24),
                      alignment: Alignment.centerLeft,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xffE3E3E4)),
                      ),
                      child: Text(clientProvider.clientPhoneNumber, style: AppTextStyles.b1)),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 48,
                  decoration: AppDecorations.gradientButtonDecoration,
                  child: MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () => context.goNamed(RouteNames.profileUpdatePhone),
                    child: Text('변경하기', style: AppTextStyles.b2BoldWhite),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('이름 변경', style: AppTextStyles.s1Bold),
            const SizedBox(height: 8),
            AppTextFields.name(controllerName),
            const SizedBox(height: 16),
            Text('주소 변경', style: AppTextStyles.s1Bold),
            const SizedBox(height: 8),
            AppTextFields.address(context, controllerAddress),
            const SizedBox(height: 16),
            AppTextFields.detailAddress(controllerDetailAddress),
            const SizedBox(height: 20),
            _cancelAndUpdateButton(),
            const SizedBox(height: 20),
            _logOutAndWithdrawalButton(),
          ],
        ),
      ),
    );
  }

  Widget _cancelAndUpdateButton() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: 48,
            decoration: AppDecorations.buttonDecoration(const Color(0xffD9D9D9)),
            child: MaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () => context.pop(),
              child: Text('취소', style: AppTextStyles.b2BoldWhite),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 7,
          child: Container(
            height: 48,
            decoration: AppDecorations.gradientButtonDecoration,
            child: MaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () async {
                FocusScope.of(context).unfocus();
                AppLoadingWidget.loadingClient(context);
                final clientProvider = Provider.of<ClientProvider>(context, listen: false);
                bool isSuccess = await clientProvider.update(
                    controllerName.text, controllerAddress.text, controllerDetailAddress.text);
                Navigator.pop(context);
                if (isSuccess) {
                  context.pop();
                } else {
                  ToastUtil.basic("정보를 수정하지 못했어요. 나중에 다시 시도해주세요.");
                }
              },
              child: Text('저장하기', style: AppTextStyles.b2BoldWhite),
            ),
          ),
        ),
      ],
    );
  }

  Widget _logOutAndWithdrawalButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => DialogUtil.logOutDialog(context),
          child: Text("로그아웃", style: AppTextStyles.c1),
        ),
        const SizedBox(width: 12),
        Container(
          margin: const EdgeInsets.only(top: 2),
          height: 12,
          width: 1,
          decoration: BoxDecoration(color: AppColors.grey2),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => DialogUtil.withdrawalDialog(context),
          child: Text("회원탈퇴", style: AppTextStyles.c1Grey),
        ),
      ],
    );
  }
}
