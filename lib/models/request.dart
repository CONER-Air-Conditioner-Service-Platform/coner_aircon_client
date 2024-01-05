import '../utils/service_request_util.dart';

class Request {
  String airconServiceRequestId; // 프로젝트 식별자
  String clientId; // 사용자 식별자
  String clientPhoneNumber; // 고객의 전화번호
  String streetAddress; // 고객의 기본 주소
  String detailedAddress; // 고객의 상세 주소
  String serviceType; // 서비스 유형
  String airconType; // 에어컨 유형
  String brandName; // 브랜드 이름
  String serviceDetails; // 서비스 상세 내용
  String desiredServiceDate; // 서비스 희망 날짜
  String addressKey; // 주소 키
  String requestSubmissionDate; // 의뢰서 제출 날짜
  String? engineerId = ''; // 엔지니어 식별자
  String? acceptanceDate = ''; // 기사님이 수락한 날짜
  String? serviceCompletionDate = ''; // 서비스를 완료한 날짜
  String? currentProgress = ''; // 현재 진행 상태
  String? servicePrice = ''; // 기사님이 적는 가격
  String? engineerMemo = ''; // 기사님이 적는 특이사항

  Request({
    required this.airconServiceRequestId,
    required this.clientId,
    required this.clientPhoneNumber,
    required this.streetAddress,
    required this.detailedAddress,
    this.engineerId,
    required this.serviceType,
    required this.airconType,
    required this.brandName,
    required this.serviceDetails,
    required this.desiredServiceDate,
    required this.addressKey,
    required this.requestSubmissionDate,
    this.acceptanceDate,
    this.serviceCompletionDate,
    this.currentProgress,
    this.servicePrice,
    this.engineerMemo,
  });

  // 파이어베이스에 저장하기 위해 Map타입으로 변경
  Map<String, dynamic> toMap(String airconServiceRequestId) {
    return {
      "airconServiceRequestId": airconServiceRequestId,
      "clientId": clientId,
      "engineerId": engineerId,
      "serviceType": serviceType,
      "airconType": airconType,
      "brandName": brandName,
      "serviceDetails": serviceDetails,
      "desiredServiceDate": desiredServiceDate,
      "addressKey": addressKey,
      "requestSubmissionDate": requestSubmissionDate,
      "acceptanceDate": acceptanceDate,
      "serviceCompletionDate": serviceCompletionDate,
      "currentProgress": currentProgress,
      "servicePrice": servicePrice,
      "engineerMemo": engineerMemo,
    };
  }

  // 파이어베이스에서 가져온 Map타입을 변경
  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      airconServiceRequestId: map['airconServiceRequestId'],
      clientId: map['clientId'],
      clientPhoneNumber: map['clientPhoneNumber'],
      streetAddress: map['streetAddress'],
      detailedAddress: map['detailedAddress'],
      engineerId: map['engineerId'],
      serviceType: map['serviceType'],
      airconType: map['airconType'],
      brandName: map['brandName'],
      serviceDetails: map['serviceDetails'],
      desiredServiceDate: map['desiredServiceDate'],
      addressKey: map['addressKey'],
      requestSubmissionDate: map['requestSubmissionDate'],
      acceptanceDate: map['acceptanceDate'],
      serviceCompletionDate: map['serviceCompletionDate'],
      currentProgress: map['currentProgress'],
      servicePrice: map['servicePrice'],
      engineerMemo: map['engineerMemo'],
    );
  }

  // // 파이어베이스에서 가져온 documentSnapshot을 변경
  // factory AirconServiceRequest.fromSnapshot(DocumentSnapshot documentSnapshot) {
  //   return AirconServiceRequest(
  //     airconServiceRequestId: documentSnapshot['airconServiceRequestId'],
  //     clientId: documentSnapshot['clientId'],
  //     engineerId: documentSnapshot['engineerId'],
  //     serviceType: documentSnapshot['serviceType'],
  //     airconType: documentSnapshot['airconType'],
  //     brandName: documentSnapshot['brandName'],
  //     serviceDetails: documentSnapshot['serviceDetails'],
  //     desiredServiceDate: documentSnapshot['desiredServiceDate'],
  //     addressKey: documentSnapshot['addressKey'],
  //     requestSubmissionDate: documentSnapshot['requestSubmissionDate'],
  //     acceptanceDate: documentSnapshot['acceptanceDate'],
  //     serviceCompletionDate: documentSnapshot['serviceCompletionDate'],
  //     currentProgress: documentSnapshot['currentProgress'],
  //     servicePrice: documentSnapshot['servicePrice'],
  //     engineerMemo: documentSnapshot['engineerMemo'],
  //   );
  // }

  void addServiceRequest() {
    currentProgress = '서비스 대기중';
    requestSubmissionDate = getToday();
  }
}
