import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';
import 'package:provider/provider.dart';

import '../../../provider/phone_verification_provider.dart';
import '../../../theme/colors.dart';
import '../../../theme/decorations.dart';
import '../../../theme/font_styles.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController verificationCodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController detailAddressController = TextEditingController();
  bool? _isPrivacy = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberController.dispose();
    verificationCodeController.dispose();
    nameController.dispose();
    addressController.dispose();
    detailAddressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phoneVerification = Provider.of<PhoneVerificationProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _phoneNumberHelper(phoneVerification),
                  const SizedBox(height: 16),
                  if (phoneVerification.isSend) ...[
                    _verificationCodeHelper(phoneVerification),
                    const SizedBox(height: 40),
                  ],
                  if (phoneVerification.isVerification) ...[
                    _nameHelper(),
                    const SizedBox(height: 16),
                    addressHelper(context, addressController),
                    const SizedBox(height: 16),
                    _detailAddressHelper(),
                  ]
                ],
              ),
            ),
          ),
          Container(
              decoration:
                  const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffDFDFDF)))),
              height: 176,
              child: Column(
                children: [
                  if (!phoneVerification.isVerification) ...[
                    const SizedBox(height: 48),
                    _phoneVerificationButton(phoneVerification)
                  ] else ...[
                    Row(
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          activeColor: conerColor2,
                          checkColor: Colors.white,
                          value: _isPrivacy,
                          onChanged: (value) => setState(() {
                            _isPrivacy = value;
                          }),
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('개인정보 수집, 이용 동의 *', style: body1),
                            const SizedBox(height: 4),
                          ],
                        )),
                        const Icon(Icons.navigate_next_rounded),
                      ],
                    ),
                    _signUpButton(phoneVerification),
                  ]
                ],
              )),
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
      decoration: InputDecoration(
        hintText: '전화번호',
        hintStyle: body1Grey,
      ),
      style: body1,
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
      decoration: InputDecoration(
        hintText: '인증번호 6자리',
        hintStyle: body1Grey,
      ),
      style: body1,
    );
  }

  Widget _nameHelper() {
    return TextFormField(
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
      controller: nameController,
      decoration: InputDecoration(
        hintText: '이름',
        hintStyle: body1Grey,
      ),
      style: body1,
    );
  }

  Widget addressHelper(BuildContext context, TextEditingController controller) {
    getAddressFromAPI() async {
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => KpostalView(
              callback: (Kpostal result) {
                controller.text = '${result.address} ${result.buildingName}';
              },
            ),
          ));
    }

    return GestureDetector(
      onTap: () => getAddressFromAPI(),
      child: TextFormField(
        autofocus: false,
        minLines: 1,
        maxLines: 2,
        enabled: false,
        decoration: InputDecoration(
          hintText: '클릭하여 주소 검색하여 주세요.',
          hintStyle: TextStyle(color: conerBlack),
        ),
        controller: controller,
        style: body1,
      ),
    );
  }

  Widget _detailAddressHelper() {
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
      controller: detailAddressController,
      decoration: InputDecoration(
        hintText: '상세주소',
        hintStyle: body1Grey,
      ),
      style: body1,
    );
  }

  Widget _phoneVerificationButton(phoneVerification) {
    return Container(
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
    );
  }

  Widget _signUpButton(phoneVerification) {
    return Container(
      height: 54,
      width: double.infinity,
      decoration: buttonDecoration,
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {},
        child: Text('회원가입', style: title2BoldWhite),
      ),
    );
  }
}
