import 'package:flutter/cupertino.dart';

import '../models/request.dart';

class RequestViewModel with ChangeNotifier {
  Request request = Request(
    airconServiceRequestId: '',
    clientId: '',
    serviceType: '청소',
    airconType: '벽걸이형',
    brandName: '삼성전자',
    serviceDetails: '',
    desiredServiceDate: '',
    addressKey: '',
    requestSubmissionDate: '',
    clientPhoneNumber: '',
    streetAddress: '',
    detailedAddress: '',
  );

  String get serviceType => request.serviceType;
  String get airconType => request.airconType;
  String get brandName => request.brandName;
  String get serviceDetails => request.serviceDetails;
  String get desiredServiceDate => request.desiredServiceDate;

  void setDesiredServiceDate(String desiredServiceDate) {
    request.desiredServiceDate = desiredServiceDate;
    notifyListeners();
  }

  void setAirconType(String newValue) {
    request.airconType = newValue;
    notifyListeners();
  }

  void setServiceType(String newValue) {
    request.serviceType = newValue;
    notifyListeners();
  }

  void setBrandName(String newValue) {
    request.brandName = newValue;
    notifyListeners();
  }
}
