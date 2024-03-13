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
  Future sendCode() async {
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
        notifyListeners();
      },
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
    );
  }

  Future<bool> checkCode() async {
    //전화 인증 코드 확인
    PhoneAuthCredential phoneAuthCredential =
        PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: verificationCode);

    final authCredential = await firebaseAuth.signInWithCredential(phoneAuthCredential);
    if (authCredential.user == null) {
      Logger().i("유저 오류");
      return false;
    }

    //임시Auth 로그아웃 및 삭제
    await firebaseAuth.currentUser?.delete();
    firebaseAuth.signOut();

    isVerification = true;
    notifyListeners();
    return true;
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
