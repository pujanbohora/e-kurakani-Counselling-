// this is use for text, button themes

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/theme/custom_fonts.dart';

//Theme.of(context).textTheme.headline1

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        scaffoldBackgroundColor:CustomColors.white,
        bottomAppBarColor: CustomColors.white,
        shadowColor: CustomColors.whiteShade,
        textTheme: const TextTheme(
            headline1: TextStyle(
                fontFamily: CustomFonts.GilroyLight,
                color: CustomColors.primaryBlue,
                fontSize: 30),
            headline2: TextStyle(
                fontSize: 25,
                fontFamily: CustomFonts.GilroyMedium,
                color: CustomColors.black),
            bodyText1: TextStyle(
                fontFamily: CustomFonts.GilroyLight,
                fontSize: 16,
                color: CustomColors.black),
            bodyText2: TextStyle(
                fontFamily: CustomFonts.GilroyLight,
                fontSize: 14,
                color: CustomColors.neutral),
            button: TextStyle(
                fontFamily: CustomFonts.GilroyLight,
                fontSize: 15,
                color: CustomColors.primaryBlue)));
  }
}
