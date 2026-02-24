import 'package:flutter/material.dart';
import 'package:my_archive/core/constants/colors.dart';

class AppTheme {
  const AppTheme._();

  static final lightTheme = ThemeData(
    useMaterial3: false,
    dialogTheme: DialogThemeData(backgroundColor: AppColor.white),
    appBarTheme: AppBarTheme(backgroundColor: AppColor.white, elevation: 0),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColor.scaffoldBackground),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColor.scaffoldBackground,
    // fontFamily: FontFamily.aeonikPro,
    colorScheme: ColorScheme(
      // Background color
      primary: AppColor.blue,
      // Text color on primary
      onPrimary: AppColor.black,
      // Secondary color
      secondary: AppColor.blue,
      // Text color on secondary
      onSecondary: Colors.black,
      // Error color
      error: AppColor.red,
      // Text color on error
      onError: AppColor.red,
      // Surface color
      surface: AppColor.blue,
      // Text color on surface
      onSurface: AppColor.white,
      // Brightness
      brightness: Brightness.light,
    ),
  );
  static final darkTheme = ThemeData(
    useMaterial3: false,
    dialogTheme: DialogThemeData(backgroundColor: AppColor.white),
    appBarTheme: AppBarTheme(backgroundColor: AppColor.white, elevation: 0),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColor.scaffoldBackgroundDark),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColor.scaffoldBackgroundDark,
    // fontFamily: FontFamily.aeonikPro,
    colorScheme: ColorScheme(
      // Background color
      primary: AppColor.blue,
      // Text color on primary
      onPrimary: AppColor.black,
      // Secondary color
      secondary: AppColor.blue,
      // Text color on secondary
      onSecondary: Colors.black,
      // Error color
      error: AppColor.red,
      // Text color on error
      onError: AppColor.red,
      // Surface color
      surface: AppColor.blue,
      // Text color on surface
      onSurface: AppColor.white,
      // Brightness
      brightness: Brightness.light,
    ),
  );
}
