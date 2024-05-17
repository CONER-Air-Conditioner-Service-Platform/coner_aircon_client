import 'package:coner_client/provider/client_provider.dart';
import 'package:coner_client/theme/app_text_styles.dart';
import 'package:coner_client/utils/dialog_util.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../configs/router/route_names.dart';
import '../../database/shared_preferences/my_shared_preferences.dart';
import '../../pakages/app_version_check_package.dart';
import '../../theme/app_decorations.dart';

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
    checkApp();
  }

  void checkApp() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      DialogUtil.networkDialog(context);
      return;
    }

    bool isCurrentVersion = await AppVersionCheckPackage.checkAppVersion();
    if (!isCurrentVersion) {
      DialogUtil.versinDialog(context);
      return;
    }
    String cid = await MySharedPreferences.getData();
    if (cid != '') {
      ClientProvider clientProvider = Provider.of<ClientProvider>(context, listen: false);
      await clientProvider.getData(cid);
    }
    if (cid.isEmpty) {
      context.goNamed(RouteNames.landing);
    } else {
      context.goNamed(RouteNames.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppDecorations.gradientDecoration,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              'assets/images/logo_white.png',
              width: 244,
              fit: BoxFit.contain,
            ),
            Text("당신을 위한 맞춤형 에어컨 서비스", style: AppTextStyles.b1BoldWhite),
          ],
        ),
      ),
    );
  }
}
