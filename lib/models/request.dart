class Request {
  String requestId; // 프로젝트 식별자
  String service; // 서비스 유형
  String aircon; // 에어컨 유형
  int airconNum; // 에어컨 대수
  String airconBrand; // 브랜드 이름
  String detailInfo; // 서비스 상세 내용
  String hopeDate; // 서비스 희망 날짜
  String hopeTime; // 서비스 희망 시간
  String phone; // 고객의 전화번호
  String address; // 고객의 기본 주소
  String detailAddress; // 고객의 상세 주소
  String state = '서비스 대기중'; // 현재 진행 상태
  String applicationDate; // 의뢰서 제출 일시
  String? acceptDate = ''; // 기사님이 수락한 날짜
  String? completeDate = ''; // 서비스를 완료한 날짜
  String? memo = ''; // 기사님이 적는 특이사항
  String? review = ''; // 기사님이 적는 특이사항
  String clientId; // 사용자 식별자
  String? engineerId = '';

  Request({
    required this.requestId,
    required this.service,
    required this.aircon,
    required this.airconNum,
    required this.airconBrand,
    required this.detailInfo,
    required this.hopeDate,
    required this.hopeTime,
    required this.phone,
    required this.address,
    required this.detailAddress,
    required this.state,
    required this.applicationDate,
    this.acceptDate,
    this.completeDate,
    this.memo,
    this.review,
    required this.clientId,
    this.engineerId,
  }); // 엔지니어 식별자

  // 파이어베이스에 저장하기 위해 Map타입으로 변경
  Map<String, dynamic> toMap(String requestId) {
    return {
      "requestId": requestId,
      "service": service,
      "aircon": aircon,
      "airconNum": airconNum,
      "airconBrand": airconBrand,
      "detailInfo": detailInfo,
      "hopeDate": hopeDate,
      "hopeTime": hopeTime,
      "phone": phone,
      "address": address,
      "detailAddress": detailAddress,
      "state": state,
      "applicationDate": applicationDate,
      "acceptDate": acceptDate,
      "completeDate": completeDate,
      "memo": memo,
      "review": review,
      "clientId": clientId,
      "engineerId": engineerId,
    };
  }

  // 파이어베이스에서 가져온 Map타입을 변경
  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      requestId: map['requestId'],
      service: map['service'],
      aircon: map['aircon'],
      airconNum: map['airconNum'],
      airconBrand: map['airconBrand'],
      detailInfo: map['detailInfo'],
      hopeDate: map['hopeDate'],
      hopeTime: map['hopeTime'],
      phone: map['phone'],
      address: map['address'],
      detailAddress: map['detailAddress'],
      state: map['state'],
      applicationDate: map['applicationDate'],
      acceptDate: map['acceptDate'],
      completeDate: map['completeDate'],
      memo: map['memo'],
      review: map['review'],
      clientId: map['clientId'],
      engineerId: map['engineerId'],
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
}
