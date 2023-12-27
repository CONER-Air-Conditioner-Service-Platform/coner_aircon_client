//import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  String clientId; // 고객의 고유 식별자
  String clientPhoneNumber; // 고객의 전화번호
  String clientName; // 고객의 이름
  String streetAddress; // 고객의 기본 주소
  String detailedAddress; // 고객의 상세 주소
  String registrationDate; // 고객 등록 날짜

  Client({
    required this.clientId,
    required this.clientPhoneNumber,
    required this.clientName,
    required this.streetAddress,
    required this.detailedAddress,
    required this.registrationDate,
  });

  // 파이어베이스에 저장하기 위해 Map타입으로 변경
  Map<String, dynamic> toMap(String clientId) {
    return {
      "clientId": clientId,
      "clientPhoneNumber": clientPhoneNumber,
      "clientName": clientName,
      "streetAddress": streetAddress,
      "detailedAddress": detailedAddress,
      "registrationDate": registrationDate,
    };
  }

  // 파이어베이스에서 가져온 Map타입을 변경
  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      clientId: map['clientId'],
      clientPhoneNumber: map['clientPhoneNumber'],
      clientName: map['clientName'],
      streetAddress: map['streetAddress'],
      detailedAddress: map['detailedAddress'],
      registrationDate: map['registrationDate'],
    );
  }

  // 파이어베이스에서 가져온 documentSnapshot을 변경
  // factory Client.fromSnapshot(DocumentSnapshot documentSnapshot) {
  //   return Client(
  //     clientId: documentSnapshot['clientId'],
  //     clientPhoneNumber: documentSnapshot['clientPhoneNumber'],
  //     clientName: documentSnapshot['clientName'],
  //     streetAddress: documentSnapshot['streetAddress'],
  //     detailedAddress: documentSnapshot['detailedAddress'],
  //     registrationDate: documentSnapshot['registrationDate'],
  //   );
  // }
}
