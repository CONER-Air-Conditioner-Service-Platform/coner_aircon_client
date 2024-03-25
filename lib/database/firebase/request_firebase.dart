import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../../models/request.dart';

class RequestFirebase {
  RequestFirebase._();
  //파이어베이스 "clients" path 선언
  static CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection("requests");

  /* 데이터 추가 */
  static Future<bool> add(Request request) async {
    try {
      DocumentReference docRef = collectionReference.doc();
      return await docRef.set(request.toMap(docRef.id)).then((value) => true);
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  /* 데이터 가져오기 */
  static Future<Request> getCurrentRequest(String cid) async {
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
    try {
      request = await collectionReference
          .where("clientId", isEqualTo: cid)
          .where("state", whereIn: ["서비스 진행중", "서비스 대기중"])
          .get()
          .then(
            (querySnapshot) {
              for (var docSnapshot in querySnapshot.docs) {
                request = Request.fromSnapshot(docSnapshot);
              }
              return request;
            },
          );
    } catch (e) {
      Logger().e(e);
    }
    return request;
  }

  static Future<List<Request>> getRequestHistory(String cid) async {
    List<Request> requestList = [];
    try {
      await collectionReference
          .where("clientId", isEqualTo: cid)
          .where("state", isEqualTo: "서비스 완료")
          .orderBy("completeDate", descending: true)
          .get()
          .then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            if (docSnapshot.data() == null) {
              return requestList;
            }
            final data = docSnapshot.data();
            requestList.add(Request.fromMap(data));
          }
        },
        onError: (e) => Logger().e("Error completing: $e"),
      );
    } catch (e) {
      Logger().e(e);
    }
    return requestList;
  }

  /* 데이터 삭제 */
  static Future delete(String requestId) async {
    bool isSuccess = false;
    try {
      DocumentReference docRef = collectionReference.doc(requestId);
      // 파이어스토어에서 삭제 완료 시, SharedPreferences 초기화
      await docRef.delete().then(
        (doc) {
          isSuccess = true;
        },
      );
    } catch (e) {
      Logger().e(e);
    }
    return isSuccess;
  }
}
