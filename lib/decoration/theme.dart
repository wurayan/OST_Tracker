import 'package:flutter/material.dart';

class ColorTheme {
  static Color blackberry = const Color(0xFF000022);
  static Color gojiberry = const Color(0xFFFC2865);
  static Color white = const Color(0xFFFDFDFD);
  static Color text = const Color(0xFF1E1D1F);
  static Color disable = const Color(0xFFCACACC);
  static Color error = const Color(0xFFD32F2F);
}

class CustomTextTheme {
  static TextStyle title = const TextStyle(
      fontFamily: "oswald", fontSize: 34, fontWeight: FontWeight.w700);
  static TextStyle subtitle = const TextStyle(
      fontFamily: "inter",
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 1);
  static TextStyle playlistCardHeader = const TextStyle(
      fontFamily: "oswald", fontSize: 32, fontWeight: FontWeight.w600);
  static TextStyle drawerItem = const TextStyle(
      fontFamily: "inter", fontSize: 22, fontWeight: FontWeight.w500);
  static TextStyle botoes = const TextStyle(
      fontFamily: "inter", fontSize: 18, fontWeight: FontWeight.w500);
  static TextStyle fab = TextStyle(
      fontFamily: "inter",
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
      color: ColorTheme.white);
  static TextStyle chips = const TextStyle(
    fontFamily: "roboto",
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
  );
  static TextStyle itemHeader = const TextStyle(
      fontFamily: "roboto",
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
      height: 1.2);
  static TextStyle itemSecondary = const TextStyle(
      fontFamily: "roboto",
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1);
  static TextStyle appbar = TextStyle(
      fontFamily: "oswald",
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: ColorTheme.text);
  static TextStyle hintText = TextStyle(
      fontFamily: "roboto",
      fontSize: 18,
      height: 1.5,
      color: ColorTheme.disable);
  static TextStyle musicaCardHeader =
      const TextStyle(fontSize: 28, fontWeight: FontWeight.w800);
  static TextStyle musicaCardSecondary =
      const TextStyle(fontSize: 18, height: 0.8, fontWeight: FontWeight.w400);
}

ThemeData white = ThemeData(
  colorScheme: ColorScheme.light(
      primary: ColorTheme.blackberry,
      secondary: ColorTheme.gojiberry,
      background: ColorTheme.white,
      error: ColorTheme.error),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    centerTitle: true,
    elevation: 0,
    foregroundColor: ColorTheme.blackberry,
    titleTextStyle: CustomTextTheme.appbar,
    shape: Border(
      bottom: BorderSide(color: ColorTheme.blackberry, width: 2),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: ColorTheme.blackberry,
        elevation: 0,
        textStyle: CustomTextTheme.botoes
        ),
  ),
  dialogTheme: const DialogTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
  ),
);
