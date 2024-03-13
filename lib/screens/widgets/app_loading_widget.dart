import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoadingWidget {
  AppLoadingWidget._();
  static void loadingClient(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  children: [
                    Lottie.asset(
                      'assets/animations/loading_person.json',
                      width: 160,
                      fit: BoxFit.contain,
                    ),
                    Text(text, style: AppTextStyles.b2),
                    Text("잠시만 기다려주세요.", style: AppTextStyles.b2),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void loadingRequest(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  children: [
                    Lottie.asset(
                      'assets/animations/loading_post.json',
                      width: 160,
                      fit: BoxFit.contain,
                    ),
                    Text(text, style: AppTextStyles.b2),
                    Text("잠시만 기다려주세요.", style: AppTextStyles.b2),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void verificationOTP(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  children: [
                    Lottie.asset(
                      'assets/animations/loading_otp.json',
                      width: 140,
                      height: 140,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 20),
                    Text("인증번호를 확인하고 있어요.", style: AppTextStyles.b2),
                    Text("잠시만 기다려주세요.", style: AppTextStyles.b2),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
