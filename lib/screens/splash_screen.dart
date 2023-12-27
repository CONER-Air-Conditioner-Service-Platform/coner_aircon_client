import 'package:coner_client/theme/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: conerColorDecoration,
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/white_logo.png',
          width: 244,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
