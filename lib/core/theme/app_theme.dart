import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/utils/generated/fonts.gen.dart';

class AppTheme {
  AppTheme._();

  static final textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
    displayMedium: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
    displaySmall: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
    headlineLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
    headlineSmall: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
    titleLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
    titleMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
    bodyLarge: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
    bodyMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700),
    labelMedium: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
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
