import 'package:flutter/material.dart';

class ThemeCustom {
  static ThemeData themeLight = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
