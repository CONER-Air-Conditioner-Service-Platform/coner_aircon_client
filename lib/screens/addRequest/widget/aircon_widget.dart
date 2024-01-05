import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/font_styles.dart';
import '../../../utils/service_request_util.dart';
import '../../../view_models/request_view_model.dart';

class AirconWidget extends StatefulWidget {
  AirconWidget({super.key});

  @override
  State<AirconWidget> createState() => _AirconWidgetState();
}

class _AirconWidgetState extends State<AirconWidget> {
  @override
  Widget build(BuildContext context) {
    final request = Provider.of<RequestViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("서비스 받을 에어컨", style: title2Bold),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(top: 10, left: 24, right: 10, bottom: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: const Color(0xffA0A0A0)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  focusColor: Colors.white,
                  value: request.aircon,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  isExpanded: true,
                  style: body1,
                  underline: SizedBox(),
                  onChanged: (String? newValue) => request.setAircon(newValue!),
                  items: airconList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(top: 10, left: 24, right: 10, bottom: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: const Color(0xffA0A0A0)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  focusColor: Colors.white,
                  value: "${request.airconNum} 대",
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  isExpanded: true,
                  style: body1,
                  underline: const SizedBox(),
                  onChanged: (String? newValue) {
                    String? extractedNumber = newValue?.substring(0, 1);
                    int number = int.parse(extractedNumber!);
                    request.setAirconNum(number);
                  },
                  items: airconNumList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
