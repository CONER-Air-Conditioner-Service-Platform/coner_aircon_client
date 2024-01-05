import 'package:coner_client/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../configs/router/route_names.dart';
import '../../../provider/phone_verification_provider.dart';
import '../../../theme/decorations.dart';
import '../../../theme/font_styles.dart';

class SignInForm extends StatefulWidget {
  SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController verificationCodeController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberController.dispose();
    verificationCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phoneVerification = Provider.of<PhoneVerificationProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          _phoneNumberHelper(phoneVerification),
          SizedBox(height: 16),
          if (phoneVerification.isSend) ...[
            _verificationCodeHelper(phoneVerification),
            SizedBox(height: 24),
          ],
          Container(
            height: 54,
            width: double.infinity,
            decoration: buttonDecoration,
            child: MaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                if (phoneVerification.isSend) {
                  phoneVerification.checkCode();
                } else {
                  phoneVerification.sendCode();
                }
              },
              child: Text(!phoneVerification.isSend ? '인증번호 보내기' : '인증하기', style: title2BoldWhite),
            ),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              phoneVerification.clear();
              context.pushNamed(RouteNames.signUp);
            },
            child: Text('회원가입 하러가기', style: body1Button),
          )
        ],
      ),
    );
  }

  Widget _phoneNumberHelper(phoneVerification) {
    return TextFormField(
      enabled: !phoneVerification.isSend,
      keyboardType: TextInputType.phone,
      autofocus: false,
      validator: (value) {
        if (value.toString().isEmpty || value.toString().length != 11) {
          return '전화번호를 입력하여 주세요.';
        } else {
          return null;
        }
      },
      minLines: 1,
      maxLines: 1,
      controller: phoneNumberController,
      decoration: InputDecoration(hintText: '전화번호', hintStyle: TextStyle(color: conerGrey)),
    );
  }

  Widget _verificationCodeHelper(phoneVerification) {
    return TextFormField(
      enabled: !phoneVerification.isVerification,
      keyboardType: TextInputType.number,
      autofocus: false,
      validator: (value) {
        if (value.toString().isEmpty || value.toString().length != 6) {
          return '인증번호 6자리를 입력하여 주세요.';
        } else {
          return null;
        }
      },
      minLines: 1,
      maxLines: 1,
      controller: verificationCodeController,
      decoration: InputDecoration(hintText: '인증번호 6자리', hintStyle: TextStyle(color: conerGrey)),
    );
  }
}
