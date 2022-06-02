import 'package:flutter/material.dart';
import 'dimensions.dart';
import 'palette.dart';

ThemeData themeMain = ThemeData(
  fontFamily: 'opensans',
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: Colors.white70,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(
      color: enableTextColor,
    ),
    titleSpacing: Dimensions.xMarginHorizontal,
    titleTextStyle: TextStyle(
      color: enableTextColor,
    ),
    toolbarTextStyle: TextStyle(
      color: enableTextColor,
      fontSize: 15,
    ),
  ),
);
