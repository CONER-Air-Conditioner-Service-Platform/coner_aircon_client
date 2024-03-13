import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';

import '../../provider/phone_verification_provider.dart';
import '../../theme/app_text_styles.dart';

class AppTextFields {
  AppTextFields._();

  static Widget phoneNumber(
      TextEditingController controller, PhoneVerificationProvider phoneVerification) {
    return TextFormField(
      controller: controller,
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
      decoration: InputDecoration(hintText: '전화번호', hintStyle: AppTextStyles.b1Grey),
      style: AppTextStyles.b1,
    );
  }

  static Widget verificationCode(
      TextEditingController controller, PhoneVerificationProvider phoneVerification) {
    return TextFormField(
      controller: controller,
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
      decoration: InputDecoration(hintText: '인증번호 6자리', hintStyle: AppTextStyles.b1Grey),
      style: AppTextStyles.b1,
    );
  }

  static Widget name(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      validator: (value) {
        if (value.toString().isEmpty) {
          return '이름을 입력하여 주세요.';
        } else {
          return null;
        }
      },
      minLines: 1,
      maxLines: 1,
      decoration: InputDecoration(hintText: '이름', hintStyle: AppTextStyles.b1Grey),
      style: AppTextStyles.b1,
    );
  }

  static Widget address(BuildContext context, TextEditingController controller) {
    getAddressFromAPI() async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => KpostalView(
            callback: (Kpostal result) {
              controller.text = '${result.address} ${result.buildingName}';
            },
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => getAddressFromAPI(),
      child: TextFormField(
        controller: controller,
        autofocus: false,
        minLines: 1,
        maxLines: 2,
        enabled: false,
        decoration: InputDecoration(
          hintText: '클릭하여 주소 검색해주세요.',
          hintStyle: AppTextStyles.b1,
        ),
        style: AppTextStyles.b1,
      ),
    );
  }

  static Widget detailAddress(TextEditingController controller) {
    return TextFormField(
      autofocus: false,
      validator: (value) {
        if (value.toString().isEmpty) {
          return '상세주소를 입력하여 주세요.';
        } else {
          return null;
        }
      },
      minLines: 1,
      maxLines: 1,
      controller: controller,
      decoration: InputDecoration(hintText: '상세주소', hintStyle: AppTextStyles.b1Grey),
      style: AppTextStyles.b1,
    );
  }
}
