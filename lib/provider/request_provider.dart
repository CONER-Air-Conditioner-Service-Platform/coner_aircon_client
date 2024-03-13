import 'package:coner_client/database/firebase/request_firebase.dart';
import 'package:coner_client/utils/service_request_util.dart';
import 'package:flutter/material.dart';

import '../models/request.dart';

class RequestProvider with ChangeNotifier {
  Request request = Request(
    requestId: '',
    service: '청소',
    aircon: '벽걸이형',
    airconNum: 1,
    airconBrand: '삼성전자',
    detailInfo: '',
    hopeDate: '',
    phone: '',
    address: '',
    detailAddress: '',
    state: '서비스 대기중',
    applicationDate: '',
    acceptDate: '',
    completeDate: '',
    memo: '',
    review: '',
    clientId: '',
    engineerId: '',
    companyId: '',
  );

  String get service => request.service;
  String get aircon => request.aircon;
  int get airconNum => request.airconNum;
  String get airconBrand => request.airconBrand;
  String get detailInfo => request.detailInfo;
  String get hopeDate => request.hopeDate;

  void setHopeDate(String hopeDate) {
    request.hopeDate = hopeDate;
    notifyListeners();
  }

  void setAircon(String newValue) {
    request.aircon = newValue;
    notifyListeners();
  }

  void setAirconNum(int newValue) {
    request.airconNum = newValue;
    notifyListeners();
  }

  void setService(String newValue) {
    request.service = newValue;
    notifyListeners();
  }

  void setAirconBrand(String newValue) {
    request.airconBrand = newValue;
    notifyListeners();
  }

  void setDetailInfo(String detailInfo) {
    request.detailInfo = detailInfo;
    notifyListeners();
  }

  Future<bool> add(
    String phone,
    String address,
    String detailAddress,
    String detailInfo,
    String clientId,
  ) async {
    request.phone = phone;
    request.address = address;
    request.detailAddress = detailAddress;
    request.detailInfo = request.detailInfo + detailInfo;
    request.applicationDate = getToday();
    request.clientId = clientId;
    bool isSuccess = await RequestFirebase.add(request);
    if (isSuccess) {
      request = Request(
        requestId: '',
        service: '청소',
        aircon: '벽걸이형',
        airconNum: 1,
        airconBrand: '삼성전자',
        detailInfo: '',
        hopeDate: '',
        phone: '',
        address: '',
        detailAddress: '',
        state: '서비스 대기중',
        applicationDate: '',
        acceptDate: '',
        completeDate: '',
        memo: '',
        review: '',
        clientId: '',
        engineerId: '',
        companyId: '',
      );
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
