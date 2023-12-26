import 'package:coner_client/theme/colors.dart';
import 'package:flutter/material.dart';

ThemeData mainTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "pretendard",
    appBarTheme: appBarTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    textTheme: TextTheme(),
    textButtonTheme:
        TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Colors.white)),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    toolbarTextStyle: const TextTheme(
      titleLarge: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    ).bodyMedium,
    titleTextStyle: const TextTheme(
      titleLarge: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    ).titleLarge,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: conerColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
