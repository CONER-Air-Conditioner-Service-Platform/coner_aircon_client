import 'package:flutter/cupertino.dart';

class PhoneVerificationProvider with ChangeNotifier {
  String phoneNumber = '';
  String verificationCode = '';
  bool isSend = false;
  bool isVerification = false;
  void sendCode() {
    isSend = true;
    notifyListeners();
  }

  void checkCode() {
    isVerification = true;
    notifyListeners();
  }

  void clear() {
    phoneNumber = '';
    verificationCode = '';
    isSend = false;
    isVerification = false;
    notifyListeners();
  }
}
