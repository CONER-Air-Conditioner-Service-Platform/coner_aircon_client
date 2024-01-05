import 'package:intl/intl.dart';

String getToday() {
  DateTime now = DateTime.now();
  DateFormat format = DateFormat('yyyy-MM-dd');
  String strToday = format.format(now);
  return strToday;
}

List<String> serviceList = [
  '청소',
  '설치',
  '수리',
  '점검',
  '이전',
  '철거',
];
List<String> serviceImageList = [
  'assets/images/service_cleaning.png',
  'assets/images/service_build.png',
  'assets/images/service_repair.png',
  'assets/images/service_inspection.png',
  'assets/images/service_deliverytruck.png',
  'assets/images/service_broken.png',
];
List<String> airconList = [
  '벽걸이형',
  '스탠드형',
  '천장형',
  '창문형',
  '냉난방기',
  '항온항습기',
  '2 in 1',
];
List<String> airconImageList = [
  'assets/images/aircon_wall.png',
  'assets/images/aircon_stand.png',
  'assets/images/aircon_ceiling.png',
  'assets/images/aircon_ceiling.png',
  'assets/images/aircon_conditioner.png',
  'assets/images/aircon_thermostat.png',
  'assets/images/aircon_thermostat.png',
];
final List<String> brandList = [
  '삼성전자',
  'LG전자',
  '캐리아',
  '위니아',
  '파세코',
  '위닉스',
  '샤오미',
  '한솔',
  '하이메이드',
  '이파람',
  '센추리',
  '귀뚜라미',
  '하이얼',
  '에어렉스',
  'SK매직',
  '기타(추천 또는 모름)',
];
final List<String> airconNumList = [
  '1 대',
  '2 대',
  '3 대',
  '4 대',
  '5 대',
  '6 대',
  '7 대',
  '8 대',
  '9 대',
  '10 대',
];
