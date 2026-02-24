import 'package:flutter/material.dart';
import 'package:my_archive/core/constants/colors.dart';

class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData(
    useMaterial3: false,
    dialogTheme: DialogThemeData(backgroundColor: AppColors.white),
    appBarTheme: AppBarTheme(backgroundColor: AppColors.white, elevation: 0),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors.scaffoldBackground),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    // fontFamily: FontFamily.aeonikPro,
    colorScheme: ColorScheme(
      // Background color
      primary: AppColors.blue,
      // Text color on primary
      onPrimary: AppColors.black,
      // Secondary color
      secondary: AppColors.blue,
      // Text color on secondary
      onSecondary: Colors.black,
      // Error color
      error: AppColors.red,
      // Text color on error
      onError: AppColors.red,
      // Surface color
      surface: AppColors.blue,
      // Text color on surface
      onSurface: AppColors.white,
      // Brightness
      brightness: Brightness.light,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: false,
    dialogTheme: DialogThemeData(backgroundColor: AppColors.white),
    appBarTheme: AppBarTheme(backgroundColor: AppColors.white, elevation: 0),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors.scaffoldDarkBackground),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.scaffoldDarkBackground,
    // fontFamily: FontFamily.aeonikPro,
    colorScheme: ColorScheme(
      // Background color
      primary: AppColors.blue,
      // Text color on primary
      onPrimary: AppColors.black,
      // Secondary color
      secondary: AppColors.blue,
      // Text color on secondary
      onSecondary: Colors.black,
      // Error color
      error: AppColors.red,
      // Text color on error
      onError: AppColors.red,
      // Surface color
      surface: AppColors.blue,
      // Text color on surface
      onSurface: AppColors.white,
      // Brightness
      brightness: Brightness.light,
    ),
  );
}
