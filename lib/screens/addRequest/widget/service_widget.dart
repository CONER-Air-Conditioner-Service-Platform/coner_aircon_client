import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/font_styles.dart';
import '../../../utils/service_request_util.dart';
import '../../../view_models/request_view_model.dart';

class ServiceWidget extends StatefulWidget {
  ServiceWidget({super.key});

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  @override
  Widget build(BuildContext context) {
    final displayRequest = Provider.of<RequestViewModel>(context);
    final request = Provider.of<RequestViewModel>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("원하는 서비스", style: title2Bold),
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
                  value: displayRequest.airconType,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  isExpanded: true,
                  style: body1,
                  underline: SizedBox(),
                  onChanged: (String? newValue) => request.setAirconType(newValue!),
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
                  value: displayRequest.serviceType,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  isExpanded: true,
                  style: body1,
                  underline: SizedBox(),
                  onChanged: (String? newValue) => request.setServiceType(newValue!),
                  items: serviceList.map<DropdownMenuItem<String>>((String value) {
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
