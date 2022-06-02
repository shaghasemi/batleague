import 'package:flutter/material.dart';

IconThemeData get mAppBarIconTheme => IconThemeData(color: mOnAppBarColor);

Color get mOnAppBarColor => const Color(0xFF000000);

Color get btnColor => const Color(0xFFED5D5E);

// Color get primaryColorTransparent => Color.fromARGB(180, 124, 66, 189);

Color get primaryColor => const Color(0xFFED5D5E);

Color get darkPrimaryColor => const Color.fromARGB(255, 74, 20, 140);

Color get accentColorOne => const Color(0xFF517C96);

Color get accentColorTwo => const Color.fromARGB(255, 252, 163, 17);

Color get accentColorThree => Colors.grey.shade500;

Color get splashBackgroundColor => const Color(0xFFFFE4E0);

Color get enableTextColor => const Color(0xFF2F2F2F);

Color get hintTextColor => const Color(0xFF808080);

Color get accentTextColor => const Color(0xFF872E2E);

MaterialColor get mainColors => MaterialColor(
      primaryColor.value,
      const <int, Color>{50: Color(0xFFFFE4E0), 100: Color(0xFFFFD5D5)},
    );

Color get iconDarkColor=>const Color(0xFF939393);