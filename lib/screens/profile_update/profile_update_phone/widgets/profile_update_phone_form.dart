import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../database/firebase/client_firebase.dart';
import '../../../../provider/client_provider.dart';
import '../../../../provider/phone_verification_provider.dart';
import '../../../../utils/dialog_util.dart';
import '../../../widgets/app_buttons.dart';
import '../../../widgets/app_loading_widget.dart';
import '../../../widgets/app_text_fields.dart';

class ProfileUpdatePhoneForm extends StatefulWidget {
  const ProfileUpdatePhoneForm({super.key});

  @override
  State<ProfileUpdatePhoneForm> createState() => _ProfileUpdatePhoneFormState();
}

class _ProfileUpdatePhoneFormState extends State<ProfileUpdatePhoneForm> {
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
    return Padding(
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
              AppLoadingWidget.loadingClient(context);
              FocusScope.of(context).unfocus();
              bool isExist =
                  await ClientFirebase.checkUserExistWithPhone(controllerPhoneNumber.text);

              if (isExist) {
                Navigator.pop(context);
                DialogUtil.basicDialog(context, "해당 전화번호로 계정이 이미 존재합니다.");
                return;
              }

              if (!phoneVerificationProvider.isSend) {
                phoneVerificationProvider.phoneNumber = controllerPhoneNumber.text;
                await phoneVerificationProvider.sendCode(context);
              } else {
                phoneVerificationProvider.verificationCode = controllerVerificationCode.text;
                bool isSuccess = await phoneVerificationProvider.checkCode(context);
                if (isSuccess) {
                  clientProvider.updatePhone(controllerPhoneNumber.text);
                  phoneVerificationProvider.clear();
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
