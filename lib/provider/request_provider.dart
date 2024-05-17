import 'dart:io';

import 'package:coner_client/database/firebase/request_firebase.dart';
import 'package:coner_client/utils/dialog_util.dart';
import 'package:coner_client/utils/service_request_util.dart';
import 'package:flutter/material.dart';

import '../models/request.dart';
import '../pakages/camera_package.dart';
import '../screens/widgets/app_loading_widget.dart';

class RequestProvider with ChangeNotifier {
  bool watchData = false;
  String repairMessage = '';
  Request request = Request(
    requestId: '',
    service: '',
    aircon: '',
    airconBrand: '',
    detailInfo: '',
    hopeDate: '',
    hopeTime: '',
    phone: '',
    address: '',
    detailAddress: '',
    state: '',
    applicationDate: '',
    acceptDate: '',
    completeDate: '',
    memo: '',
    review: '',
    clientId: '',
    engineerId: '',
    engineerName: '',
    engineerPhone: '',
    engineerProfileImage: '',
    companyId: '',
    companyName: '',
    companyAddress: '',
    companyDetailAddress: '',
    requestImageList: [],
  );
  List<Request> requestHistoryList = [];
  List<File?> requestImageFileList = <File?>[];
  String get requestId => request.requestId;
  String get service => request.service;
  String get aircon => request.aircon;
  String get hopeTime => request.hopeTime;
  String get airconBrand => request.airconBrand;
  String get detailInfo => request.detailInfo;
  String get hopeDate => request.hopeDate;
  String get clientPhone => request.phone;
  String get clientAddress => request.address;
  String get clientDetailAddress => request.detailAddress;
  String get clientState => request.state;
  String get clientApplicationDate => request.applicationDate;
  String get clientAcceptDate => request.acceptDate ?? '';
  String get clientCompleteDate => request.completeDate ?? '';
  String get engineerName => request.engineerName ?? '';
  String get engineerPhone => request.engineerPhone ?? '';
  String get engineerProfileImage => request.engineerProfileImage ?? '';
  String get companyName => request.companyName ?? '';
  String get companyAddress => request.companyAddress ?? '';
  String get companyDetailAddress => request.companyDetailAddress ?? '';
  String get state => request.state ?? '';

  void setRequest(Request request) {
    this.request = request;
    notifyListeners();
  }

  void setHopeTime(String hopeTime) {
    this.request.hopeTime = hopeTime;
    notifyListeners();
  }

  void setRepairMessage(String repairMessage) {
    this.repairMessage = repairMessage;
    notifyListeners();
  }

  void setHopeDate(String hopeDate) {
    request.hopeDate = hopeDate;
    notifyListeners();
  }

  void setAircon(String newValue) {
    request.aircon = newValue;
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

  Future addRequestImage() async {
    requestImageFileList.addAll((await CameraPackage.getImages(requestImageFileList)));
    notifyListeners();
  }

  void removeRequestImage(int index) {
    requestImageFileList.removeAt(index);
    notifyListeners();
  }

  void clearRequestImage() {
    requestImageFileList.clear();
    notifyListeners();
  }

  Future<bool> add(
    BuildContext context,
    String phone,
    String address,
    String detailAddress,
    String detailInfo,
    String clientId,
  ) async {
    if (hopeDate == '') {
      DialogUtil.basicDialog(context, "희망 날짜를 선택해주세요.");
      return false;
    }
    if (detailInfo == '') {
      DialogUtil.basicDialog(context, "요청사항을 작성해주세요.");
      return false;
    }

    AppLoadingWidget.loadingRequest(context);

    request.phone = phone;
    request.state = "서비스 대기중";
    request.address = address;
    request.detailAddress = detailAddress;
    request.detailInfo = service == '수리' ? repairMessage + detailInfo : detailInfo;
    request.applicationDate = getToday();
    request.clientId = clientId;
    bool isSuccess = await RequestFirebase.add(request, requestImageFileList);
    Navigator.pop(context);
    if (isSuccess) {
      request = Request(
        requestId: '',
        service: '',
        aircon: '',
        airconBrand: '',
        detailInfo: '',
        hopeDate: '',
        hopeTime: '',
        phone: '',
        address: '',
        detailAddress: '',
        state: '',
        applicationDate: '',
        acceptDate: '',
        completeDate: '',
        memo: '',
        review: '',
        clientId: '',
        engineerId: '',
        engineerName: '',
        engineerPhone: '',
        engineerProfileImage: '',
        companyId: '',
        companyName: '',
        companyAddress: '',
        companyDetailAddress: '',
        requestImageList: [],
      );
      getData(clientId);
      requestImageFileList = [];
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> update(
    BuildContext context,
    String phone,
    String address,
    String detailAddress,
    String detailInfo,
    String clientId,
  ) async {
    request.phone = phone;
    request.state = "서비스 대기중";
    request.address = address;
    request.detailAddress = detailAddress;
    request.detailInfo = service == '수리' ? repairMessage + detailInfo : detailInfo;
    request.applicationDate = getToday();
    request.clientId = clientId;
    bool isSuccess = await RequestFirebase.update(request, requestImageFileList);
    if (isSuccess) {
      getData(clientId);
      requestImageFileList = [];
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future getRequestHistory(String clientId) async {
    requestHistoryList = await RequestFirebase.getRequestHistory(clientId);
    notifyListeners();
  }

  Future getData(String clientId) async {
    Request? newRequest = await RequestFirebase.getCurrentRequest(clientId);
    if (newRequest != null) {
      if (newRequest!.state != '') {
        request = newRequest!;
      }
    }

    notifyListeners();
  }

  void updateData(Request request) {
    request = request;
    notifyListeners();
  }

  Future<bool> delete() async {
    bool isDelete = false;
    isDelete = await RequestFirebase.delete(request);
    request = Request(
      requestId: '',
      service: '',
      aircon: '',
      airconBrand: '',
      detailInfo: '',
      hopeDate: '',
      hopeTime: '',
      phone: '',
      address: '',
      detailAddress: '',
      state: '',
      applicationDate: '',
      acceptDate: '',
      completeDate: '',
      memo: '',
      review: '',
      clientId: '',
      engineerId: '',
      engineerName: '',
      engineerPhone: '',
      engineerProfileImage: '',
      companyId: '',
      companyName: '',
      companyAddress: '',
      companyDetailAddress: '',
      requestImageList: [],
    );
    notifyListeners();
    return isDelete;
  }
}
