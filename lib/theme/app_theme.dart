import 'package:flutter/material.dart';

import '../../../constant/constants.dart';
import '../constant/color_styles.dart';
import 'button_theme.dart';
import 'checkbox_themedata.dart';
import 'input_decoration_theme.dart';
import 'theme_data.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: "Plus Jakarta",
      primarySwatch: primaryMaterialColor,
      primaryColor: ColorStyles.appTextColor,
      scaffoldBackgroundColor: ColorStyles.appBackGroundColor,
      iconTheme: const IconThemeData(color: blackColor),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: blackColor40),
        bodySmall: TextStyle(color: ColorStyles.appTextColor),
        bodyLarge: TextStyle(color: ColorStyles.appTextColor),
        titleSmall: TextStyle(color: ColorStyles.appTextColor),
        headlineSmall: TextStyle(color: ColorStyles.appTextColor),
        titleLarge: TextStyle(
            fontSize: 20,
            color: ColorStyles.appTextColor,
            shadows: [
              Shadow(
                  offset: Offset(-20, 0), // Gölgenin konumu
                  blurRadius: 50.0, // Gölgenin bulanıklık derecesi
                  color: ColorStyles.appTextColor),
              Shadow(
                  offset: Offset(20, 0), // Gölgenin konumu
                  blurRadius: 50.0, // Gölgenin bulanıklık derecesi
                  color: ColorStyles.appTextColor),
            ],
            fontFamily: 'Montserrat'),
      ),
      elevatedButtonTheme: elevatedButtonThemeData,
      textButtonTheme: textButtonThemeData,
      outlinedButtonTheme: outlinedButtonTheme(),
      inputDecorationTheme: lightInputDecorationTheme,
      checkboxTheme: checkboxThemeData.copyWith(
        side: const BorderSide(color: blackColor40),
      ),
      appBarTheme: appBarLightTheme,
      scrollbarTheme: scrollbarThemeData,
      dataTableTheme: dataTableLightThemeData,
    );
  }

  // Dark theme is inclided in the Full template
}
