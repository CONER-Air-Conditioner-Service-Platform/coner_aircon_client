import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/client_provider.dart';
import '../../../../provider/phone_verification_provider.dart';
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
              if (!phoneVerificationProvider.isSend) {
                phoneVerificationProvider.phoneNumber = controllerPhoneNumber.text;
                phoneVerificationProvider.sendCode();
              } else {
                AppLoadingWidget.loadingClient(context, "전화번호 변경중입니다.");
                phoneVerificationProvider.verificationCode = controllerVerificationCode.text;
                bool isSuccess = await phoneVerificationProvider.checkCode();
                if (isSuccess) {
                  clientProvider.updatePhone(controllerPhoneNumber.text);
                  phoneVerificationProvider.clear();
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
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
