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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SignInAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Image.asset(
                      AppAssets.logoColorBottom,
                      width: AppSize.ratioOfHorizontal(context, 0.2),
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 28),
                    const SignInForm(),
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
