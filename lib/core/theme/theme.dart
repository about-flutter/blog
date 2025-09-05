import 'package:blog/core/theme/appPalette.dart';
import 'package:flutter/material.dart';

class AppTheme {

static border([Color color = AppPalette.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color, 
      width: 2
      ),
    borderRadius: BorderRadius.circular(10),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPalette.backgroundColor,
    ),
   inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(16),
    enabledBorder: border(),
    focusedBorder: border(AppPalette.gradient2),
   )
  );
}
