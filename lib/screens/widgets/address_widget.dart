import 'package:coner_client/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';

Widget findAddressHelper(BuildContext context, TextEditingController controller) {
  getAddressFromAPI() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => KpostalView(
          useLocalServer: false,
          localPort: 1024,
          kakaoKey: '5b995b84b90ab6a4b1bbd0e95c0dc842',
          callback: (Kpostal result) {
            controller.text = controller.text = '${result.address} ${result.buildingName}';
          },
        ),
      ),
    );
  }

  return GestureDetector(
    onTap: () => getAddressFromAPI(),
    child: TextFormField(
      autofocus: false,
      minLines: 1,
      maxLines: 2,
      enabled: false,
      decoration: InputDecoration(
        hintText: '주소 검색하기',
        hintStyle: TextStyle(color: AppColors.grey2),
      ),
      controller: controller,
    ),
  );
}
