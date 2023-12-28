import 'dart:async';

import 'package:coner_client/configs/router/route_names.dart';
import 'package:coner_client/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
