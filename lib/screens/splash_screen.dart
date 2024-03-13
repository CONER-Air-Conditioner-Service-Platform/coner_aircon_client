import 'package:coner_client/provider/client_provider.dart';
import 'package:coner_client/utils/toast_util.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../configs/router/route_names.dart';
import '../database/shared_preferences/my_shared_preferences.dart';
import '../pakages/app_version_check_package.dart';
import '../theme/app_decorations.dart';

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
    appCheck();
  }

  void appCheck() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      ToastUtil.basic("인터넷을 연결해주세요.");
      return;
    }

    bool isCurrentVersion = await AppVersionCheckPackage.checkAppVersion();
    if (!isCurrentVersion) {
      return;
    }
    String cid = await MySharedPreferences.getData();
    Logger().i(cid);
    if (cid != '') {
      ClientProvider clientProvider = Provider.of<ClientProvider>(context, listen: false);
      await clientProvider.getData(cid);
    }
    context.goNamed(RouteNames.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppDecorations.gradientDecoration,
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
