import 'package:coner_client/provider/client_provider.dart';
import 'package:coner_client/provider/phone_verification_provider.dart';
import 'package:coner_client/provider/request_provider.dart';
import 'package:coner_client/theme/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'configs/router/app_router.dart';
import 'database/shared_preferences/my_shared_preferences.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String cid = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCidFromSharedPreferences();
  }

  void getCidFromSharedPreferences() async {
    cid = await MySharedPreferences.getData();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ClientProvider()),
        ChangeNotifierProvider(create: (context) => PhoneVerificationProvider()),
        ChangeNotifierProvider(create: (context) => RequestProvider()),
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
