import 'package:cloud_firestore/cloud_firestore.dart';

class Engineer {
  String engineerId; // 기사의 고유 식별자
  String engineerPhone; // 기사의 전화번호
  String engineerName; // 기사의 이름
  String engineerAddress; // 기사의 기본 주소
  String engineerDetailAddress; // 기사의 상세 주소
  int engineerCountOfComplete; // 기사 완료 의뢰 건 수
  String engineerCertificate; // 기사 자격 증명 자료
  String engineerRRNF; // 기사 주민번호 (앞자리)
  String engineerRRNB; // 기사 주민번호 (뒷자리)
  String engineerProfile; // 기사 프로필 사진
  String engineerSignUpDate; // 기사 등록 날짜
  String gradeId; // 기사 등급 코드
  String companyId; // 회사 고유 식별자
  String companyName; // 회사 이름

  Engineer({
    required this.engineerId,
    required this.engineerPhone,
    required this.engineerName,
    required this.engineerAddress,
    required this.engineerDetailAddress,
    required this.engineerCountOfComplete,
    required this.engineerCertificate,
    required this.engineerRRNF,
    required this.engineerRRNB,
    required this.engineerProfile,
    required this.engineerSignUpDate,
    required this.gradeId,
    required this.companyId,
    required this.companyName,
  });

  // 파이어베이스에 저장하기 위해 Map타입으로 변경
  Map<String, dynamic> toMap(String engineerId) {
    return {
      "engineerId": engineerId,
      "engineerPhoneNumber": engineerPhone,
      "engineerName": engineerName,
      "engineerAddress": engineerAddress,
      "engineerDetailAddress": engineerDetailAddress,
      "engineerCountOfComplete": engineerCountOfComplete,
      "engineerCertificate": engineerCertificate,
      "engineerRRNF": engineerRRNF,
      "engineerRRNB": engineerRRNB,
      "engineerProfile": engineerProfile,
      "engineerSignUpDate": engineerSignUpDate,
      "gradeId": gradeId,
      "companyId": companyId,
      "companyName": companyName,
    };
  }

  // 파이어베이스에서 가져온 Map타입을 변경
  factory Engineer.fromMap(Map<String, dynamic> map) {
    return Engineer(
      engineerId: map['engineerId'],
      engineerPhone: map['engineerPhoneNumber'],
      engineerName: map['engineerName'],
      engineerAddress: map['engineerAddress'],
      engineerDetailAddress: map['engineerDetailAddress'],
      engineerCountOfComplete: map['engineerCountOfComplete'],
      engineerCertificate: map['engineerCertificate'],
      engineerRRNF: map['engineerRRNF'],
      engineerRRNB: map['engineerRRNB'],
      engineerProfile: map['engineerProfile'],
      engineerSignUpDate: map['engineerSignUpDate'],
      gradeId: map['gradeId'],
      companyId: map['companyId'],
      companyName: map['companyName'],
    );
  }

  //파이어베이스에서 가져온 documentSnapshot을 변경
  factory Engineer.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return Engineer(
      engineerId: documentSnapshot['engineerId'],
      engineerPhone: documentSnapshot['engineerPhoneNumber'],
      engineerName: documentSnapshot['engineerName'],
      engineerAddress: documentSnapshot['engineerAddress'],
      engineerDetailAddress: documentSnapshot['engineerDetailAddress'],
      engineerCountOfComplete: documentSnapshot['engineerCountOfComplete'],
      engineerCertificate: documentSnapshot['engineerCertificate'],
      engineerRRNF: documentSnapshot['engineerRRNF'],
      engineerRRNB: documentSnapshot['engineerRRNB'],
      engineerProfile: documentSnapshot['engineerProfile'],
      engineerSignUpDate: documentSnapshot['engineerSignUpDate'],
      gradeId: documentSnapshot['gradeId'],
      companyId: documentSnapshot['companyId'],
      companyName: documentSnapshot['companyName'],
    );
  }
}
