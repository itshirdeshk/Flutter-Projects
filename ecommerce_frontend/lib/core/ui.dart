import 'package:flutter/material.dart';

class AppColors {
  static Color accent = const Color(0xff1ab7c3);
  static Color text = const Color(0xff212121);
  static Color textLight = const Color(0xFF8A8A8A);
  static Color white = const Color(0xffffffff);
}

class Themes {
  static ThemeData defaultTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.white,
          iconTheme: IconThemeData(color: AppColors.text),
          titleTextStyle: TextStyle(
              fontSize: 18,
              color: AppColors.text,
              fontWeight: FontWeight.w500)),
      colorScheme: ColorScheme.light(
        primary: AppColors.accent,
        secondary: AppColors.accent,
      ));
}

class TextStyles {
  static TextStyle heading1 = TextStyle(
      fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.text);

      static TextStyle heading2 = TextStyle(
      fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.text);

      static TextStyle heading3 = TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.text);

      static TextStyle body1 = TextStyle(
      fontSize: 18, fontWeight: FontWeight.normal, color: AppColors.text);

      static TextStyle body2 = TextStyle(
      fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.text);
}
