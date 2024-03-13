import 'package:coner_client/provider/client_provider.dart';
import 'package:coner_client/screens/widgets/app_buttons.dart';
import 'package:coner_client/screens/widgets/app_text_fields.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../configs/router/route_names.dart';
import '../../../database/firebase/client_firebase.dart';
import '../../../provider/phone_verification_provider.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/toast_util.dart';
import '../../widgets/app_loading_widget.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final controllerPhoneNumber = TextEditingController();
  final controllerVerificationCode = TextEditingController();

  @override
  void dispose() {
    controllerPhoneNumber.dispose();
    controllerVerificationCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phoneVerificationProvider = Provider.of<PhoneVerificationProvider>(context);
    final clientProvider = Provider.of<ClientProvider>(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AppTextFields.phoneNumber(controllerPhoneNumber, phoneVerificationProvider),
            const SizedBox(height: 16),
            if (phoneVerificationProvider.isSend) ...[
              AppTextFields.verificationCode(controllerVerificationCode, phoneVerificationProvider),
              const SizedBox(height: 24),
            ],
            AppButtons.verification(
              phoneVerificationProvider,
              () async {
                if (_formKey.currentState?.validate() != true) return;
                if (!phoneVerificationProvider.isSend) {
                  bool isExist =
                      await ClientFirebase.checkUserExistWithPhone(controllerPhoneNumber.text);
                  if (!isExist) {
                    ToastUtil.basic("해당 전화번호로 계정이 존재하지 않습니다.");
                    return;
                  }
                  phoneVerificationProvider.phoneNumber = controllerPhoneNumber.text;
                  phoneVerificationProvider.sendCode();
                } else {
                  AppLoadingWidget.loadingClient(context, "로그인중입니다.");
                  phoneVerificationProvider.verificationCode = controllerVerificationCode.text;
                  bool isSuccess = await phoneVerificationProvider.checkCode();
                  if (isSuccess) {
                    clientProvider.login(controllerPhoneNumber.text);
                    phoneVerificationProvider.clear();
                    Navigator.pop(context);
                    context.goNamed(RouteNames.splash);
                  } else {
                    Navigator.pop(context);
                  }
                }
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                phoneVerificationProvider.clear();
                context.pushNamed(RouteNames.signUp);
              },
              child: Text('회원가입 하러가기', style: AppTextStyles.b2BoldUnderline),
            )
          ],
        ),
      ),
    );
  }
}
