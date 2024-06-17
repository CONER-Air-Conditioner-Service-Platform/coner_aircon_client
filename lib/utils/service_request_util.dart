import 'package:intl/intl.dart';

import '../theme/app_assets.dart';

String getToday() {
  DateTime now = DateTime.now();
  DateFormat format = DateFormat('yyyy-MM-dd');
  String strToday = format.format(now);
  return strToday;
}

List<String> serviceList = [
  '청소',
  '설치',
  '이전',
  '수리',
  '철거',
];
List<String> serviceImageList = [
  'assets/images/service_cleaning.png',
  'assets/images/service_build.png',
  'assets/images/service_relocation.png',
  'assets/images/service_repair.png',
  'assets/images/service_broken.png',
];
List<String> airconList = [
  '벽걸이형',
  '스탠드형',
  '천장형',
  '창문형',
  '항온항습기',
];
List<String> airconImageList = [
  'assets/images/aircon_wall.png',
  'assets/images/aircon_stand.png',
  'assets/images/aircon_ceiling.png',
  'assets/images/aircon_window.png',
  'assets/images/aircon_thermostat.png',
];
final List<String> brandList = [
  '삼성전자',
  'LG전자',
  '캐리아',
  '센추리',
  '귀뚜라미',
  'SK매직',
  '기타(추천 또는 모름)',
];

final List<String> failureSymptoms = [
  "에어컨이 작동하지 않아요.",
  "에어컨에서 이상한 소리가 나요.",
  "에어컨 전원이 켜지지 않아요.",
  "에어컨에서 이상한 냄새가 나요.",
  "에어컨에서 물이 흘러나와요.",
  "에어컨이 부분적으로만 작동돼요.",
  "에어컨이 자동으로 꺼지거나 켜져요.",
  "에어컨 온도 조절이 잘 안돼요.",
  "기타",
];

(String, String, String) tagImageMapping(
    String airconType, String serivceType, String state, String hopeDate) {
  String serviceTag = '', airconTag = '', servicePrograss = '';
  switch (airconType) {
    case "벽걸이형":
      airconTag = AppAssets.tagWall;
      break;
    case "천장형":
      airconTag = AppAssets.tagCeiling;
      break;
    case "항온항습기":
      airconTag = AppAssets.tagThermostat;
      break;
    case "창문형":
      airconTag = AppAssets.tagWindow;
      break;
    case "스탠드형":
      airconTag = AppAssets.tagStand;
      break;
  }
  switch (serivceType) {
    case "청소":
      serviceTag = AppAssets.tagClean;
      break;
    case "설치":
      serviceTag = AppAssets.tagInstallation;
      break;
    case "수리":
      serviceTag = AppAssets.tagRepair;
      break;
    case "점검":
      serviceTag = AppAssets.tagInspection;
      break;
    case "이전":
      serviceTag = AppAssets.tagRelocation;
      break;
    case "철거":
      serviceTag = AppAssets.tagRemoval;
      break;
  }

  switch (state) {
    case "서비스 대기중":
      servicePrograss = AppAssets.serviceProgass1;
      break;
    case "서비스 진행중":
      if (hopeDate == getToday()) {
        servicePrograss = AppAssets.serviceProgass3;
      } else {
        servicePrograss = AppAssets.serviceProgass2;
      }
      break;
  }
  return (airconTag, serviceTag, servicePrograss);
}
