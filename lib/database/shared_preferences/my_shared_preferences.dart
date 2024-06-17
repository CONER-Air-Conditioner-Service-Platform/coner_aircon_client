import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences를 관리하는 클래스
///
/// 마지막 수정 : 2023-8-24
class MySharedPreferences {
  /// 저장소 가져오기
  static Future getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('clientId') ?? '';
  }

  /// 저장소에 데이터 저장
  static Future setData(String cid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("clientId", cid);
  }

  /// 저장소 비우기
  static Future clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("clientId");
  }
}
