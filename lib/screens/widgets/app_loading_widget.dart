import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoadingWidget {
  AppLoadingWidget._();
  static void loadingClient(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, //바깥 영역 터치시 닫을지 여부 결정
      builder: (context) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Lottie.asset(
                  'assets/animations/loading_person.json',
                  width: 160,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void loadingRequest(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, //바깥 영역 터치시 닫을지 여부 결정
      builder: (context) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Lottie.asset(
                  'assets/animations/loading_post.json',
                  width: 160,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
