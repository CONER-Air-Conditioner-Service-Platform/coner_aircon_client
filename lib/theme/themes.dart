import 'package:coner_client/theme/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData mainTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "mainFont",
    appBarTheme: appBarTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    textTheme: const TextTheme(),
    textButtonTheme:
        TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Colors.white)),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Color(0xFFA0A0A0)),
  );
  OutlineInputBorder fucusedInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: AppColors.coner2),
  );

  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    enabledBorder: outlineInputBorder,
    focusedBorder: fucusedInputBorder,
    border: outlineInputBorder,
  );
}
