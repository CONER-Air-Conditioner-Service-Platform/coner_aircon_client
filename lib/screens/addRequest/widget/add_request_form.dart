import 'package:coner_client/theme/colors.dart';
import 'package:coner_client/theme/font_styles.dart';
import 'package:coner_client/theme/widget_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../theme/decorations.dart';

class AddRequestForm extends StatefulWidget {
  AddRequestForm({super.key});

  @override
  State<AddRequestForm> createState() => _AddRequestFormState();
}

class _AddRequestFormState extends State<AddRequestForm> {
  final formKey = GlobalKey<FormState>();
  List<String> scopeOfServiceLocation = [
    '서울 도봉구',
    '서울 동대문구',
    '서울 은평구',
    '서울 강북구',
    '서울 관악구',
    '서울 광진구',
    '서울 종로구',
    '서울 중랑구',
    '서울 노원구',
    '서울 성북구',
    '경기 시흥시'
  ];

  final List<String> typeOfAircon = ['벽걸이형', '스탠드형', '천장형', '항온항습기', '2 in 1', '기타'];
  String selectedAircon = '벽걸이형';

  final List<String> typeOfService = ['설치', '수리', '이전', '철거', '기타'];
  String selectedService = '설치';

  final List<String> typeOfBrand = [
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
  String selectedBrand = '삼성전자';

  TextEditingController desiredServiceDateController = TextEditingController();

  TextEditingController brandController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController detailedAddressController = TextEditingController();

  TextEditingController serviceDetailsController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    desiredServiceDateController.dispose();
    brandController.dispose();
    addressController.dispose();
    detailedAddressController.dispose();
    serviceDetailsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("방문 희망 예정일", style: title2Bold),
              Text("방문 희망 예정일은 신청일로부터 한 달 이후까지 가능합니다.", style: body2Grey),
              const SizedBox(height: 8),
              _calenderHelper(),
              const SizedBox(height: 12),
              Text("원하는 서비스", style: title2Bold),
              const SizedBox(height: 8),
              Row(
                children: [
                  _airconHelper(),
                  const SizedBox(width: 12),
                  _serviceHelper(),
                ],
              ),
              const SizedBox(height: 12),
              Text("브랜드", style: title2Bold),
              const SizedBox(height: 8),
              _brandHelper(),
              const SizedBox(height: 12),
              _clientInfoHelper(),
              const SizedBox(height: 12),
              Text("특이사항 및 세부사항", style: title2Bold),
              const SizedBox(height: 8),
              _serviceDetailedHelper(),
              const SizedBox(height: 40),
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("의뢰서 수정은 기사님 배정 전까지만 가능합니다.", style: body1),
                    Text("의뢰하시겠습니까?", style: body1Bold),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 54,
                      decoration: cancleButtonDecoration,
                      child: MaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {},
                        child: Text('취소', style: title2BoldWhite),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 7,
                    child: Container(
                      height: 54,
                      decoration: buttonDecoration,
                      child: MaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {},
                        child: Text('의뢰하기', style: title2BoldWhite),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _calenderHelper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            HapticFeedback.mediumImpact();
            _selectDataCalendar_Expecteddate_visit(context);
          },
          child: AbsorbPointer(
            child: TextFormField(
              decoration: const InputDecoration(suffixIcon: Icon(Icons.calendar_month)),
              controller: desiredServiceDateController,
            ),
          ),
        ),
      ],
    );
  }

  /// 캘린더를 띄우는 메소드
  void _selectDataCalendar_Expecteddate_visit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SizedBox(
            width: ratioOfVertical(context, 0.8),
            height: ratioOfHorizontal(context, 0.4),
            child: SfDateRangePicker(
              monthFormat: 'MMM',
              headerStyle:
                  DateRangePickerHeaderStyle(textAlign: TextAlign.center, textStyle: title1Bold),
              headerHeight: ratioOfVertical(context, 0.1),
              monthCellStyle: DateRangePickerMonthCellStyle(
                textStyle: title2,
                todayTextStyle: title2,
                disabledDatesTextStyle: title2Grey,
              ),
              selectionShape: DateRangePickerSelectionShape.rectangle,
              view: DateRangePickerView.month,
              showNavigationArrow: true,
              allowViewNavigation: false,
              backgroundColor: ThemeData.light().scaffoldBackgroundColor,
              initialSelectedDate: DateTime.now().add(const Duration(days: 1)),
              minDate: DateTime.now().add(const Duration(days: 1)), //오늘 날짜 +1부터 시작일로 선택 가능
              maxDate: DateTime.now().add(const Duration(days: 30)),
              selectionMode: DateRangePickerSelectionMode.single,
              selectionColor: conerColor2,
              selectionTextStyle: title2BoldWhite,
              todayHighlightColor: conerColor2,
              showActionButtons: true,
              confirmText: '선택하기',
              onSubmit: (args) => {
                setState(() {
                  desiredServiceDateController.clear();
                  desiredServiceDateController.text = args.toString();
                  _convertDateTimeDisplay(desiredServiceDateController.text, '방문');
                  Navigator.of(context).pop();
                }),
              },
              cancelText: '취소',
              onCancel: () => Navigator.of(context).pop(),
            ),
          ),
        );
      },
    );
  }

  /// 캘린더에서 선택한 날짜를 포맷팅하고 컨트롤러에 넣어주는 메소드
  String _convertDateTimeDisplay(String date, String text) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    if (text == '방문') {
      desiredServiceDateController.clear();
      return desiredServiceDateController.text = serverFormater.format(displayDate);
    } else {
      return desiredServiceDateController.text = serverFormater.format(displayDate);
    }
  }

  Widget _clientInfoHelper() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("주소", style: title2Bold), Text("수정하기", style: body1BoldGrey)],
        ),
        const SizedBox(height: 8),
        Container(
          child: TextFormField(
            autofocus: false,
            minLines: 1,
            maxLines: 2,
            enabled: false,
            decoration: InputDecoration(
              hintText: '서울시 중랑구 중랑천로 43 신성아파트',
              hintStyle: TextStyle(color: conerGrey),
            ),
            controller: addressController,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          autofocus: false,
          minLines: 1,
          maxLines: 2,
          enabled: false,
          decoration:
              InputDecoration(hintText: '102동 901호', hintStyle: TextStyle(color: conerGrey)),
          controller: detailedAddressController,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("연락처", style: title2Bold), Text("수정하기", style: body1BoldGrey)],
        ),
        const SizedBox(height: 8),
        TextFormField(
          autofocus: false,
          minLines: 1,
          maxLines: 2,
          enabled: false,
          decoration:
              InputDecoration(hintText: '010-5543-0636', hintStyle: TextStyle(color: conerGrey)),
          controller: detailedAddressController,
        ),
      ],
    );
  }

  Widget _airconHelper() {
    return Expanded(
      child: Container(
        height: 50,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: const Color(0xffA0A0A0)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          focusColor: Colors.white,
          value: selectedAircon,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          isExpanded: true,
          style: body1,
          underline: SizedBox(),
          onChanged: (String? newValue) {
            setState(() {
              selectedAircon = newValue!;
            });
          },
          items: typeOfAircon.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }

  Widget _serviceHelper() {
    return Expanded(
      child: Container(
        height: 50,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: const Color(0xffA0A0A0)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          focusColor: Colors.white,
          value: selectedService,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          isExpanded: true,
          style: body1,
          underline: SizedBox(),
          onChanged: (String? newValue) {
            setState(() {
              selectedService = newValue!;
            });
          },
          items: typeOfService.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }

  Widget _brandHelper() {
    return Container(
      height: 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color(0xffA0A0A0)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        focusColor: Colors.white,
        value: selectedBrand,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        isExpanded: true,
        style: body1,
        underline: SizedBox(),
        onChanged: (String? newValue) {
          setState(() {
            selectedBrand = newValue!;
          });
        },
        items: typeOfBrand.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
      ),
    );
  }

  Widget _serviceDetailedHelper() {
    return TextFormField(
      autofocus: false,
      validator: (value) {
        if (value.toString().isEmpty) {
          return '특이사항 및 세부사항을 입력해주세요.';
        } else {
          return null;
        }
      },
      minLines: 8,
      maxLines: 8,
      controller: serviceDetailsController,
      decoration: InputDecoration(hintStyle: TextStyle(color: Colors.grey[600])),
    );
  }
}
