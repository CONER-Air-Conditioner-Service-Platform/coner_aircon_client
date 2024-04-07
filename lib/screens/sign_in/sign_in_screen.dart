import 'package:coner_client/screens/sign_in/widgets/sign_in_app_bar.dart';
import 'package:coner_client/screens/sign_in/widgets/sign_in_form.dart';
import 'package:coner_client/theme/app_assets.dart';
import 'package:coner_client/theme/app_size.dart';
import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SignInAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    Image.asset(
                      AppAssets.logoColorBottom,
                      width: AppSize.ratioOfHorizontal(context, 0.1),
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 28),
                    SignInForm(),
                    Text("계정 생성시 개인정보 처리방침 및", style: AppTextStyles.c1Grey),
                    Text("이용약관(마케팅 정보 수신 동의 포함)에 동의하게 됩니다.", style: AppTextStyles.c1Grey),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
