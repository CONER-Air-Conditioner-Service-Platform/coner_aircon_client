// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
//
// import '../../models/client.dart';
//
// class ClientFirebase {
//   //파이어베이스 "users" path 선언
//   CollectionReference<Map<String, dynamic>> collectionReference =
//       FirebaseFirestore.instance.collection("client");
//   /* 데이터 추가 */
//   Future add(BuildContext context, Client client) async {
//     try {
//       DocumentReference docRef = collectionReference.doc();
//       await docRef.set(client.toMap(docRef.id)).then((value) {
//         //성공 메시지
//       });
//     } catch (e) {
//       //실패 메시지
//     }
//   }
// }
