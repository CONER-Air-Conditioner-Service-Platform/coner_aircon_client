import 'package:coner_client/provider/client_provider.dart';
import 'package:coner_client/screens/widgets/app_buttons.dart';
import 'package:coner_client/screens/widgets/app_text_fields.dart';
import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../configs/router/route_names.dart';
import '../../../database/firebase/client_firebase.dart';
import '../../../provider/phone_verification_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_decorations.dart';
import '../../../utils/dialog_util.dart';
import '../../widgets/app_loading_widget.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final controllerPhoneNumber = TextEditingController();
  final controllerVerificationCode = TextEditingController();
  final controllerName = TextEditingController();
  final controllerAddress = TextEditingController();
  final controllerDetailAddress = TextEditingController();

  bool isPrivacy = false;

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
    final phoneVerificationProvider = Provider.of<PhoneVerificationProvider>(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppTextFields.phoneNumber(controllerPhoneNumber, phoneVerificationProvider),
                    const SizedBox(height: 16),
                    if (phoneVerificationProvider.isSend) ...[
                      AppTextFields.verificationCode(
                          controllerVerificationCode, phoneVerificationProvider),
                      const SizedBox(height: 40),
                    ],
                    if (phoneVerificationProvider.isVerification) ...[
                      AppTextFields.name(controllerName),
                      const SizedBox(height: 16),
                      AppTextFields.address(context, controllerAddress),
                      const SizedBox(height: 16),
                      AppTextFields.detailAddress(controllerDetailAddress),
                    ]
                  ],
                ),
              ),
            ),
            _bottomSheetHelper(phoneVerificationProvider),
          ],
        ),
      ),
    );
  }

  Widget _bottomSheetHelper(PhoneVerificationProvider phoneVerificationProvider) {
    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffDFDFDF)))),
      height: 176,
      child: Column(
        children: [
          if (!phoneVerificationProvider.isVerification) ...[
            const SizedBox(height: 48),
            AppButtons.verification(
              phoneVerificationProvider,
              () async {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState?.validate() != true) return;
                AppLoadingWidget.loadingClient(context);
                if (!phoneVerificationProvider.isSend) {
                  bool isExist =
                      await ClientFirebase.checkUserExistWithPhone(controllerPhoneNumber.text);
                  if (isExist) {
                    Navigator.pop(context);
                    DialogUtil.basicDialog(context, "해당 전화번호로 계정이 이미 존재합니다. 로그인해주세요.");
                    return;
                  }
                  phoneVerificationProvider.phoneNumber = controllerPhoneNumber.text;
                  await phoneVerificationProvider.sendCode(context);
                } else {
                  phoneVerificationProvider.verificationCode = controllerVerificationCode.text;
                  bool isSuccess = await phoneVerificationProvider.checkCode(context);
                  if (isSuccess) {
                    Navigator.pop(context);
                  }
                }
              },
            )
          ] else ...[
            _privacyHelper(),
            _signUpButton(),
          ]
        ],
      ),
    );
  }

  Widget _signUpButton() {
    final clientProvider = Provider.of<ClientProvider>(context);
    final phoneVerificationProvider = Provider.of<PhoneVerificationProvider>(context);
    return Container(
      height: 48,
      width: double.infinity,
      decoration: AppDecorations.gradientButtonDecoration,
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () async {
          FocusScope.of(context).unfocus();
          if (controllerName.text.length < 2) {
            DialogUtil.basicDialog(context, "이름을 2자 이상 작성해주세요.");
            return;
          }

          if (controllerAddress.text.isEmpty || controllerDetailAddress.text.isEmpty) {
            DialogUtil.basicDialog(context, "주소를 작성해주세요.");
            return;
          }

          if (!isPrivacy) {
            DialogUtil.basicDialog(context, "개인정보 처리방침에 동의해주세요.");
            return;
          }

          AppLoadingWidget.loadingClient(context);
          bool isSuccess = await clientProvider.add(
            controllerPhoneNumber.text,
            controllerName.text,
            controllerAddress.text,
            controllerDetailAddress.text,
          );
          Navigator.pop(context);
          if (isSuccess) {
            phoneVerificationProvider.clear();
            context.goNamed(RouteNames.signUpSuccess);
          } else {
            DialogUtil.basicDialog(context, "회원가입을 실패하였습니다. 나중에 다시 시도해주세요.");
          }
        },
        child: Text('회원가입', style: AppTextStyles.s1BoldWhite),
      ),
    );
  }

  Widget _privacyHelper() {
    return Row(
      children: [
        Checkbox(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          activeColor: AppColors.coner2,
          checkColor: Colors.white,
          value: isPrivacy,
          onChanged: (value) => setState(() {
            isPrivacy = value!;
          }),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => context.pushNamed(RouteNames.privacyPolicy),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('개인정보 수집, 이용 동의 *', style: AppTextStyles.b1),
                const SizedBox(height: 4)
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => context.pushNamed(RouteNames.privacyPolicy),
          child: const Icon(Icons.navigate_next_rounded),
        ),
      ],
    );
  }
}
