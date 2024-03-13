import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info/package_info.dart';

class AppVersionCheckPackage {
  static Future checkAppVersion() async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("version").doc("release_version");
    String str_minAppVersion = "", str_latestAppVersion = "";
    await docRef.get().then((DocumentSnapshot snapshot) => {
          str_minAppVersion = snapshot['minVersion'] ?? '',
          str_latestAppVersion = snapshot['latestVersion'] ?? '',
        });

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    //String buildNumber = packageInfo.buildNumber;

    var arrVersion = version.split(".");
    var arrMinVersion = str_minAppVersion.split(".");
    var arrLatestVersion = str_latestAppVersion.split(".");

    int verion = int.parse(arrVersion[0] + arrVersion[1] + arrVersion[2]);
    int minVersion = int.parse(arrMinVersion[0] + arrMinVersion[1] + arrMinVersion[2]);
    int latestAppVersion =
        int.parse(arrLatestVersion[0] + arrLatestVersion[1] + arrLatestVersion[2]);

    if (arrMinVersion[0] != '' || arrLatestVersion[0] != '') {
      // 허용된 낮은 버전과 제일 높은 버전 사이에 현재 버전이 있을 시, 데이터를 불러오기.
      // 아닐 시, 업데이트 하라는 화면으로 이동.
      if (minVersion <= verion && verion <= latestAppVersion) {
        return true;
      } else {
        return false;
      }
    }
  }
}
