import 'package:coner_client/provider/phone_verification_provider.dart';
import 'package:coner_client/theme/themes.dart';
import 'package:coner_client/view_models/client_view_model.dart';
import 'package:coner_client/view_models/request_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'configs/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RequestViewModel()),
        ChangeNotifierProvider(create: (context) => ClientViewModel()),
        ChangeNotifierProvider(create: (context) => PhoneVerificationProvider()),
      ],
      child: MaterialApp.router(
        theme: mainTheme(),
        routerConfig: AppRouter.router,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ko', '')],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
