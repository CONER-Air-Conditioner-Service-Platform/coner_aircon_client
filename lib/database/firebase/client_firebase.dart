import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coner_client/database/shared_preferences/my_shared_preferences.dart';
import 'package:logger/logger.dart';

import '../../models/client.dart';

class ClientFirebase {
  ClientFirebase._();
  //파이어베이스 "clients" path 선언
  static CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection("clients");

  /* 데이터 추가 */
  static Future<String> add(Client client) async {
    String cid = '';
    try {
      DocumentReference docRef = collectionReference.doc();
      await docRef.set(client.toMap(docRef.id)).then((value) {
        cid = docRef.id;
        MySharedPreferences.setData(docRef.id);
      });
    } catch (e) {
      Logger().e(e);
    }
    return cid;
  }

  /* 데이터 가져오기 */
  static Future getData(String cid) async {
    Client client;
    try {
      DocumentReference docRef = collectionReference.doc(cid);
      client = await docRef.get().then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        Client client = Client.fromMap(data);
        // 파이어스토어에서 가져오기 완료 시, SharedPreferences에 저장
        MySharedPreferences.setData(client.clientId);
        return client;
      });
      return client;
    } catch (e) {
      Logger().e(e);
    }
  }

  /* 데이터 삭제 */
  static Future delete(String cid) async {
    bool isSuccess = false;
    try {
      DocumentReference docRef = collectionReference.doc(cid);
      // 파이어스토어에서 삭제 완료 시, SharedPreferences 초기화
      await docRef.delete().then(
        (doc) {
          MySharedPreferences.clear();
          isSuccess = true;
        },
      );
    } catch (e) {
      Logger().e(e);
    }
    return isSuccess;
  }

  /* 데이터 변경 */
  static Future<bool> update(
    String cid,
    String clientName,
    String clientAddress,
    String clientDetailAddress,
  ) async {
    bool isSuccess = false;
    try {
      DocumentReference docRef = collectionReference.doc(cid);
      await docRef.update({
        "clientName": clientName,
        "clientAddress": clientAddress,
        "clientDetailAddress": clientDetailAddress,
      }).then((val) async {
        isSuccess = true;
      });
    } catch (e) {
      Logger().e(e);
    }
    return isSuccess;
  }

  static Future<bool> updatePhone(String cid, String clientPhoneNumber) async {
    bool isSuccess = false;
    try {
      DocumentReference docRef = collectionReference.doc(cid);
      await docRef.update({"clientPhoneNumber": clientPhoneNumber}).then((val) async {
        isSuccess = true;
      });
    } catch (e) {
      Logger().e(e);
    }
    return true;
  }

  /* 유저 관리 */
  static Future login(String phone) async {
    try {
      String cid = '';
      await collectionReference.where("clientPhoneNumber", isEqualTo: phone).get().then(
        (querySnapshot) {
          //문서 존재 ->  uid를 변수에 저장하고 true를 반환.
          if (querySnapshot.docs.isNotEmpty) {
            for (var docSnapshot in querySnapshot.docs) {
              cid = docSnapshot.id;
            }
          }
        },
      );
      return getData(cid);
    } catch (e) {
      Logger().e(e);
    }
  }

  /* 데이터 체크 */
  // 전화번호가 데이터베이스에 등록되어 있는지 확인
  static Future checkUserExistWithPhone(String phone) async {
    bool isExist = false;
    try {
      await collectionReference.where("clientPhoneNumber", isEqualTo: phone).get().then(
        (querySnapshot) {
          //문서 존재 ->  uid를 변수에 저장하고 true를 반환.
          if (querySnapshot.docs.isNotEmpty) {
            // for (var docSnapshot in querySnapshot.docs) {
            //   uid = docSnapshot.id;
            // }
            isExist = true;
          }
        },
      );
    } catch (e) {
      Logger().e(e);
    }
    return isExist;
  }
}
