import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../configs/router/route_names.dart';
import '../../theme/app_text_styles.dart';

class SignUpSuccessScreen extends StatefulWidget {
  const SignUpSuccessScreen({super.key});

  @override
  State<SignUpSuccessScreen> createState() => _SignUpSuccessScreenState();
}

class _SignUpSuccessScreenState extends State<SignUpSuccessScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () => context.goNamed(RouteNames.main));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animations/success_animation.json', height: 200),
            const SizedBox(height: 8),
            Text('회원가입 완료!', style: AppTextStyles.h2Bold),
            const SizedBox(height: 4),
            Text('코너에서 편리하게 에어컨을 관리하세요!', style: AppTextStyles.c1BoldGrey),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
