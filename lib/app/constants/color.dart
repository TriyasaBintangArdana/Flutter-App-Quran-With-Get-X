import 'package:flutter/material.dart';

const appPurple = Color(0xFF431AA1);
const appWhite = Color(0xFFFAF8FC);
const appPurpleLight = Color(0xFF9345F2);
const appPurpleYoung = Color(0xFFFB9A2DB);
const appOrange = Color(0xFFFE6704A);

const appPurpleDark = Color(0xFF1E0771);

ThemeData themeLight  = ThemeData(
  brightness: Brightness.light,
  primaryColor: appPurple,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: appPurpleDark
  ),
  scaffoldBackgroundColor: appWhite,
  appBarTheme: AppBarTheme(
    backgroundColor: appPurple
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      color: appPurple
    ),
    titleLarge: TextStyle(
      color: appPurple
    ),
    titleMedium: TextStyle(
      color: appPurple
    ),
    bodyLarge: TextStyle(
      color: appPurple
    ),
    bodyMedium: TextStyle(
      color: appPurple
    ),
    bodySmall: TextStyle(
      color: appPurple
    ),
    displayLarge: TextStyle(
      color: appPurple
    ),
    displayMedium: TextStyle(
      color: appPurple
    ),
    displaySmall: TextStyle(
      color: appPurple
    ),
    labelLarge: TextStyle(
      color: appPurple
    ),
    labelMedium: TextStyle(
      color: appPurple
    ),
    labelSmall: TextStyle(
      color: appPurple
    ),
    headlineLarge: TextStyle(
      color: appPurple
    ),
    headlineMedium: TextStyle(
      color: appPurple
    ),
    headlineSmall: TextStyle(
      color: appPurple
    ),

  )
);
ThemeData themeDark  = ThemeData(
  brightness: Brightness.dark,
  primaryColor: appPurpleYoung,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: appWhite
  ),
  scaffoldBackgroundColor: appPurpleDark,
  appBarTheme: AppBarTheme(
    backgroundColor: appPurpleDark
  ),
  textTheme: TextTheme(
   titleSmall: TextStyle(
      color: appWhite
    ),
    titleLarge: TextStyle(
      color: appWhite
    ),
    titleMedium: TextStyle(
      color: appWhite
    ),
    bodyLarge: TextStyle(
      color: appWhite
    ),
    bodyMedium: TextStyle(
      color: appWhite
    ),
    bodySmall: TextStyle(
      color: appWhite
    ),
    displayLarge: TextStyle(
      color: appWhite
    ),
    displayMedium: TextStyle(
      color: appWhite
    ),
    displaySmall: TextStyle(
      color: appWhite
    ),
    labelLarge: TextStyle(
      color: appWhite
    ),
    labelMedium: TextStyle(
      color: appWhite
    ),
    labelSmall: TextStyle(
      color: appWhite
    ),
    headlineLarge: TextStyle(
      color: appWhite
    ),
    headlineMedium: TextStyle(
      color: appWhite
    ),
    headlineSmall: TextStyle(
      color: appWhite
    ),
  )
);

