import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../configs/router/route_names.dart';
import '../theme/decorations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      context.goNamed(RouteNames.main);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: conerColorDecoration,
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/logo_white.png',
          width: 244,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
