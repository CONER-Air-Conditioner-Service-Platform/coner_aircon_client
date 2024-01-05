import 'package:coner_client/view_models/client_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/font_styles.dart';

class MyInfoWidget extends StatelessWidget {
  const MyInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final displayClient = Provider.of<ClientViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("주소", style: title2Bold), Text("수정하기", style: body1BoldGrey)],
        ),
        const SizedBox(height: 8),
        TextFormField(
          autofocus: false,
          minLines: 1,
          maxLines: 2,
          enabled: false,
          decoration: InputDecoration(
            hintText: displayClient.clientAddress == ''
                ? '서울시 중랑구 중랑천로 43 신성아파트'
                : displayClient.clientAddress,
            hintStyle: body1Grey,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          autofocus: false,
          minLines: 1,
          maxLines: 2,
          enabled: false,
          decoration: InputDecoration(
            hintText: displayClient.clientDetailAddress == ''
                ? '102동 901호'
                : displayClient.clientDetailAddress,
            hintStyle: body1Grey,
          ),
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
          decoration: InputDecoration(
            hintText: displayClient.clientPhoneNumber == ''
                ? '01055430636'
                : displayClient.clientPhoneNumber,
            hintStyle: body1Grey,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
