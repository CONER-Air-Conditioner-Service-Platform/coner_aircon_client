import 'package:flutter/material.dart';

import '../../provider/phone_verification_provider.dart';
import '../../theme/app_decorations.dart';
import '../../theme/app_text_styles.dart';

class AppButtons {
  AppButtons._();
  static Widget verification(PhoneVerificationProvider phoneVerification, Function()? function) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: AppDecorations.gradientButtonDecoration,
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: function,
        child:
            Text(!phoneVerification.isSend ? '인증번호 보내기' : '인증하기', style: AppTextStyles.b1BoldWhite),
      ),
    );
  }
}
