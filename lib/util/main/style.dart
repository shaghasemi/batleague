import 'package:flutter/material.dart';
import 'color.dart';

String font = 'opensans';

ThemeData themeLightData = ThemeData(
  fontFamily: font,
  primarySwatch: primaryLightColor,
  appBarTheme: const AppBarTheme(),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: c_250Color,
  textSelectionTheme: TextSelectionThemeData(cursorColor: hintColor),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return Colors.red;
          return null; // Defer to the widget's default.
        },
      ),
      shadowColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return Colors.pink;
          return Colors.black; // Defer to the widget's default.
        },
      ),
    ),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 72.0,
      fontWeight: FontWeight.bold,
      fontFamily: font,
    ),
    headline6: TextStyle(
      fontSize: 36.0,
      fontStyle: FontStyle.italic,
      fontFamily: font,
    ),
    bodyText2: TextStyle(
      fontSize: 14.0,
      fontFamily: font,
    ),
  ),
);

ThemeData themeDarkData = ThemeData(
  fontFamily: font,
  brightness: Brightness.dark,
  primarySwatch: primaryDarkColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: c_50Color,
  textSelectionTheme: TextSelectionThemeData(cursorColor: hintColor),
  snackBarTheme: SnackBarThemeData(
    contentTextStyle: TextStyle(fontFamily: font, fontSize: 13),
  ),
);

ThemeData tabBarThemeData = ThemeData(
  fontFamily: font,
  primarySwatch: backColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: c_250Color,
  textSelectionTheme: TextSelectionThemeData(cursorColor: hintColor),
  snackBarTheme: SnackBarThemeData(
    contentTextStyle: TextStyle(fontFamily: font, fontSize: 13),
  ),
);

TextStyle hintStyle = TextStyle(
  color: hintColor,
  fontSize: 13,
  fontFamily: font,
);
