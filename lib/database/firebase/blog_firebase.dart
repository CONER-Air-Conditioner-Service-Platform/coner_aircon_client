import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coner_client/database/shared_preferences/my_shared_preferences.dart';
import 'package:logger/logger.dart';

import '../../models/client.dart';

class BlogFirebase {
  BlogFirebase._();
  //파이어베이스 "clients" path 선언
  static CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection("blog");
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
}
