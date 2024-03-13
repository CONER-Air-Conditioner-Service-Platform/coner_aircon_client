import 'package:coner_client/configs/router/route_names.dart';
import 'package:coner_client/provider/client_provider.dart';
import 'package:coner_client/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_text_styles.dart';

class MyInfoWidget extends StatelessWidget {
  const MyInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("주소", style: AppTextStyles.s1Bold),
            GestureDetector(
              onTap: () {
                if (clientProvider.clientId == '') {
                  DialogUtil.logInDialog(context);
                } else {
                  context.pushNamed(RouteNames.profileUpdate);
                }
              },
              child: Text("수정하기", style: AppTextStyles.b2BoldGrey),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          autofocus: false,
          minLines: 1,
          maxLines: 2,
          enabled: false,
          decoration: InputDecoration(
            hintText: clientProvider.clientAddress,
            hintStyle: AppTextStyles.b1Grey,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          autofocus: false,
          minLines: 1,
          maxLines: 2,
          enabled: false,
          decoration: InputDecoration(
            hintText: clientProvider.clientDetailAddress,
            hintStyle: AppTextStyles.b1Grey,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("연락처", style: AppTextStyles.s1Bold),
            GestureDetector(
              onTap: () {
                if (clientProvider.clientId == '') {
                  DialogUtil.logInDialog(context);
                } else {
                  context.pushNamed(RouteNames.profileUpdate);
                }
              },
              child: Text("수정하기", style: AppTextStyles.b2BoldGrey),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          autofocus: false,
          minLines: 1,
          maxLines: 2,
          enabled: false,
          decoration: InputDecoration(
            hintText: clientProvider.clientPhoneNumber,
            hintStyle: AppTextStyles.b1Grey,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
