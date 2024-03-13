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
  static Future getCurrentRequest(String cid) async {
    try {
      return await collectionReference.where("state", isEqualTo: ["서비스 대기중", "서비스 진행중"]).get().then(
            (querySnapshot) {
              if (querySnapshot.docs.isNotEmpty) {
                for (var docSnapshot in querySnapshot.docs) {
                  Request request = Request.fromSnapshot(docSnapshot);
                  return request;
                }
              }
            },
          );
    } catch (e) {
      Logger().e(e);
    }
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
