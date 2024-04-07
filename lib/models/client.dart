import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  String clientId; // 고객의 고유 식별자
  String clientPhoneNumber; // 고객의 전화번호
  String clientName; // 고객의 이름
  String clientAddress; // 고객의 기본 주소
  String clientDetailAddress; // 고객의 상세 주소
  String clientSignUpDate; // 고객 등록 날짜

  Client({
    required this.clientId,
    required this.clientPhoneNumber,
    required this.clientName,
    required this.clientAddress,
    required this.clientDetailAddress,
    required this.clientSignUpDate,
  });

  // 파이어베이스에 저장하기 위해 Map타입으로 변경
  Map<String, dynamic> toMap(String clientId) {
    return {
      "clientId": clientId,
      "clientPhoneNumber": clientPhoneNumber,
      "clientName": clientName,
      "clientAddress": clientAddress,
      "clientDetailAddress": clientDetailAddress,
      "clientSignUpDate": clientSignUpDate,
    };
  }

  // 파이어베이스에서 가져온 Map타입을 변경
  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      clientId: map['clientId'],
      clientPhoneNumber: map['clientPhoneNumber'],
      clientName: map['clientName'],
      clientAddress: map['clientAddress'],
      clientDetailAddress: map['clientDetailAddress'],
      clientSignUpDate: map['clientSignUpDate'],
    );
  }

  //파이어베이스에서 가져온 documentSnapshot을 변경
  factory Client.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return Client(
      clientId: documentSnapshot['clientId'],
      clientPhoneNumber: documentSnapshot['clientPhoneNumber'],
      clientName: documentSnapshot['clientName'],
      clientAddress: documentSnapshot['clientAddress'],
      clientDetailAddress: documentSnapshot['clientDetailAddress'],
      clientSignUpDate: documentSnapshot['clientSignUpDate'],
    );
  }
}
