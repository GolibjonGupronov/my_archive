import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/exports/core_exports.dart';

class AppTheme {
  AppTheme._();

  static final textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, fontFamily: _getFontFamily),
    displayMedium: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, fontFamily: _getFontFamily),
    displaySmall: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, fontFamily: _getFontFamily),
    headlineLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, fontFamily: _getFontFamily),
    headlineMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: _getFontFamily),
    headlineSmall: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, fontFamily: _getFontFamily),
    titleLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, fontFamily: _getFontFamily),
    titleMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, fontFamily: _getFontFamily),
    titleSmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, fontFamily: _getFontFamily),
    bodyLarge: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, fontFamily: _getFontFamily),
    bodyMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, fontFamily: _getFontFamily),
    bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, fontFamily: _getFontFamily),
    labelLarge: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700, fontFamily: _getFontFamily),
    labelMedium: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500, fontFamily: _getFontFamily),
    labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, fontFamily: _getFontFamily),
  );

  static final lightTheme = ThemeData(
    useMaterial3: false,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    fontFamily: FontFamily.aeonikPro,
    dialogTheme: DialogThemeData(backgroundColor: AppColors.white),
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.scaffoldBackground, elevation: 0, iconTheme: IconThemeData(color: AppColors.black)),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors.scaffoldBackground),
    textTheme: textTheme,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: ColorScheme(
      // Background color
      primary: AppColors.primary,
      // Text color on primary
      onPrimary: AppColors.black,
      // Secondary color
      secondary: AppColors.primary,
      // Text color on secondary
      onSecondary: AppColors.gray,
      // Error color
      error: AppColors.red,
      // Text color on error
      onError: AppColors.red,
      // Surface color
      surface: AppColors.primary,
      // Text color on surface
      onSurface: AppColors.black,
      // Brightness
      brightness: Brightness.light,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: false,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.scaffoldDarkBackground,
    fontFamily: FontFamily.aeonikPro,
    dialogTheme: DialogThemeData(backgroundColor: AppColors.scaffoldDarkBackground),
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.scaffoldDarkBackground, elevation: 0, iconTheme: IconThemeData(color: AppColors.white)),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors.scaffoldDarkBackground),
    textTheme: textTheme,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: ColorScheme(
      // Background color
      primary: AppColors.primary,
      // Text color on primary
      onPrimary: AppColors.black,
      // Secondary color
      secondary: AppColors.primary,
      // Text color on secondary
      onSecondary: AppColors.gray,
      // Error color
      error: AppColors.red,
      // Text color on error
      onError: AppColors.red,
      // Surface color
      surface: AppColors.primary,
      // Text color on surface
      onSurface: AppColors.white,
      // Brightness
      brightness: Brightness.dark,
    ),
  );
}

String get _getFontFamily => FontFamily.aeonikPro;
