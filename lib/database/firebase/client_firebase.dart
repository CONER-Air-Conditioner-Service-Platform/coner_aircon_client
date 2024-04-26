import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coner_client/database/shared_preferences/my_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../models/client.dart';
import '../../provider/client_provider.dart';

class ClientFirebase {
  ClientFirebase._();
  //파이어베이스 "clients" path 선언
  static CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection("clients");

  /* 데이터 추가 */
  static Future add(Client client) async {
    try {
      DocumentReference docRef = collectionReference.doc();
      return await docRef.set(client.toMap(docRef.id)).then((value) {
        MySharedPreferences.setData(docRef.id);
        return docRef.id;
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  /* 데이터 가져오기 */
  static Future getData(String cid) async {
    Client client = Client(
      clientId: '',
      clientPhoneNumber: '',
      clientName: '',
      clientAddress: '',
      clientDetailAddress: '',
      clientSignUpDate: '',
    );
    try {
      DocumentReference docRef = collectionReference.doc(cid);
      client = await docRef.get().then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        Client newClient = Client.fromMap(data);
        // 파이어스토어에서 가져오기 완료 시, SharedPreferences에 저장
        MySharedPreferences.setData(newClient.clientId);
        return newClient;
      });
    } catch (e) {
      Logger().e(e);
    }
    return client;
  }

  /* 데이터 삭제 */
  static Future delete(String cid) async {
    try {
      DocumentReference docRef = collectionReference.doc(cid);
      // 파이어스토어에서 삭제 완료 시, SharedPreferences 초기화
      return await docRef.delete().then(
        (doc) {
          MySharedPreferences.clear();
          return true;
        },
      );
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  /* 데이터 변경 */
  static Future<bool> update(
    String cid,
    String clientName,
    String clientAddress,
    String clientDetailAddress,
  ) async {
    try {
      DocumentReference docRef = collectionReference.doc(cid);
      return await docRef.update({
        "clientName": clientName,
        "clientAddress": clientAddress,
        "clientDetailAddress": clientDetailAddress,
      }).then((val) async {
        return true;
      });
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  static Future<bool> updatePhone(String cid, String clientPhoneNumber) async {
    try {
      DocumentReference docRef = collectionReference.doc(cid);
      return await docRef.update({"clientPhoneNumber": clientPhoneNumber}).then((val) => true);
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  /* 유저 관리 */
  static Future login(BuildContext context, String phone) async {
    try {
      String cid = '';
      await collectionReference.where("clientPhoneNumber", isEqualTo: phone).get().then(
        (querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            for (var docSnapshot in querySnapshot.docs) {
              cid = docSnapshot.id;
            }
          }
        },
      );
      Provider.of<ClientProvider>(context, listen: false).setCId(cid);
      return getData(cid);
    } catch (e) {
      Logger().e(e);
    }
  }

  /* 데이터 체크 */
  // 전화번호가 데이터베이스에 등록되어 있는지 확인
  static Future<bool> checkUserExistWithPhone(String phone) async {
    try {
      return await collectionReference.where("clientPhoneNumber", isEqualTo: phone).get().then(
        (querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            return true;
          } else {
            return false;
          }
        },
      );
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }
}
