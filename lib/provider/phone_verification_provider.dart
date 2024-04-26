import 'package:coner_client/utils/dialog_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class PhoneVerificationProvider with ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String phoneNumber = '';
  String verificationCode = '';
  String? reason;
  int? resendingToken;
  String? verificationId;

  bool isSend = false;
  bool isVerification = false;
  Future sendCode(BuildContext context) async {
    var resendingToken;
    firebaseAuth.setSettings(appVerificationDisabledForTesting: false);

    await firebaseAuth.verifyPhoneNumber(
      codeAutoRetrievalTimeout: (String verificationId) {},
      phoneNumber: _changePhoneCode(phoneNumber),
      forceResendingToken: resendingToken,
      verificationFailed: (e) => Logger().i(e),
      codeSent: (verificationId, resendingToken) async {
        this.verificationId = verificationId;
        this.resendingToken = resendingToken;
        isSend = true;
        Navigator.pop(context);
        notifyListeners();
      },
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
        Logger().e(phoneAuthCredential.smsCode);
      },
    );
  }

  Future checkCode(BuildContext context) async {
    bool isSuccess = false;
    try {
      //전화 인증 코드 확인
      PhoneAuthCredential phoneAuthCredential =
          PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: verificationCode);
      final authCredential = await firebaseAuth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user == null) {
        Navigator.pop(context);
        DialogUtil.basicDialog(context, "인증에 실패하였습니다. 다시 시도해주세요.");
        isSuccess = false;
      }

      //임시Auth 로그아웃 및 삭제
      await firebaseAuth.currentUser?.delete();
      firebaseAuth.signOut();

      isVerification = true;
      isSuccess = true;
      notifyListeners();
    } catch (e) {
      Navigator.pop(context);
      Logger().e(e);
      isSuccess = false;

      DialogUtil.basicDialog(context, "인증에 실패하였습니다. 다시 시도해주세요.");
    }
    return isSuccess;
  }

  void clear() {
    phoneNumber = '';
    verificationCode = '';
    isSend = false;
    isVerification = false;
    notifyListeners();
  }

  String _changePhoneCode(String mobile) {
    return '+82' + mobile.substring(1);
  }

  String _changePhoneNumber(String mobile) {
    return '0' + mobile.substring(3);
  }
}
