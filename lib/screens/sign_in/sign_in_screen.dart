import 'package:coner_client/screens/sign_in/widgets/sign_in_app_bar.dart';
import 'package:coner_client/screens/sign_in/widgets/sign_in_form.dart';
import 'package:flutter/material.dart';

import '../../theme/font_styles.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SignInAppBar(),
          SizedBox(height: 48),
          Image.asset("assets/images/logo_bottom_name_image.png"),
          SizedBox(height: 28),
          SignInForm(),
          TextButton(
            onPressed: () {},
            child: Text('회원가입 하러가기', style: body1Button),
          )
        ],
      ),
    );
  }
}
