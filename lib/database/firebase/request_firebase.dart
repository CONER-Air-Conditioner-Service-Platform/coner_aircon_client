import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

import '../../models/request.dart';

class RequestFirebase {
  RequestFirebase._();
  //파이어베이스 "clients" path 선언
  static CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection("requests");
  static final storage = FirebaseStorage.instance;

  /* 데이터 추가 */
  static Future<bool> add(Request request, List<File?> requestImageList) async {
    try {
      DocumentReference docRef = collectionReference.doc();

      //Storage에 사진 저장
      for (int i = 0; i < requestImageList.length; i++) {
        await _uploadImageFile(docRef.id, 'requestImageList$i', requestImageList[i]!).then((value) {
          if (value != null) {
            request.requestImageList.add(value);
          }
        });
      }

      return await docRef.set(request.toMap(docRef.id)).then((value) => true);
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  /* 데이터 수정 */
  static Future<bool> update(Request request, List<File?> requestImageList) async {
    try {
      DocumentReference docRef = collectionReference.doc(request.requestId);

      request.requestImageList.clear();
      //Storage에 사진 저장
      for (int i = 0; i < requestImageList.length; i++) {
        await _uploadImageFile(request.requestId, 'requestImageList$i', requestImageList[i]!)
            .then((value) {
          if (value != null) {
            request.requestImageList.add(value);
          }
        });
      }

      return await docRef.update(request.toMap(request.requestId)).then((value) => true);
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  /* 데이터 가져오기 */
  static Future<Request?> getCurrentRequest(String cid) async {
    Request request = Request(
      requestId: '',
      service: '설치',
      aircon: '벽걸이형',
      airconBrand: '삼성전자',
      detailInfo: '',
      hopeDate: '',
      hopeTime: '',
      phone: '',
      address: '',
      detailAddress: '',
      state: '',
      applicationDate: '',
      acceptDate: '',
      completeDate: '',
      memo: '',
      review: '',
      clientId: '',
      engineerId: '',
      engineerName: '',
      engineerPhone: '',
      engineerProfileImage: '',
      companyId: '',
      companyName: '',
      companyAddress: '',
      companyDetailAddress: '',
      requestImageList: [],
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
    if (request.clientId == '') {
      return null;
    }
    return request;
  }

  static Future<int> getRequestProgressCount(String cid) async {
    int requestCount = 0;
    try {
      await collectionReference
          .where("clientId", isEqualTo: cid)
          .where("state", whereIn: ["서비스 진행중", "서비스 대기중"])
          .get()
          .then(
            (querySnapshot) {
              requestCount = querySnapshot.docs.length;
            },
            onError: (e) => Logger().e("Error completing: $e"),
          );
    } catch (e) {
      Logger().e(e);
    }
    return requestCount;
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
  static Future delete(Request request) async {
    bool isSuccess = false;
    try {
      DocumentReference docRef = collectionReference.doc(request.requestId);

      //파이어스토리지에 있는 이미지 파일 삭제
      //상세 이미지 삭제
      final storageRef = storage.ref();
      for (int i = 0; i < request.requestImageList.length; i++) {
        final ref = storageRef.child("requests/${request.requestId}/requestImageList$i.jpg");
        await ref.delete();
      }
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

  static Future _uploadImageFile(String requestId, String fileType, File file) async {
    try {
      final storageRef = storage.ref();
      final mountainsRef =
          storageRef.child('requests/$requestId').child('/$fileType.jpg'); //사진 저장 경로
      //Storage에 사진 저장
      UploadTask uploadTask = mountainsRef.putFile(file);

      //해당하는 사진 종류를 찾아 url변수 저장
      String url = await (await uploadTask).ref.getDownloadURL();
      return url;
    } catch (e) {
      Logger().e("데이터베이스 저장 실패! \n $e");
    }
  }
}
