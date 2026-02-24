import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/constants/colors.dart';

class AppTheme {
  AppTheme._();

  static final textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 18.sp, color: AppColors.black, fontWeight: FontWeight.w700),
    displayMedium: TextStyle(fontSize: 18.sp, color: AppColors.black, fontWeight: FontWeight.w500),
    displaySmall: TextStyle(fontSize: 18.sp, color: AppColors.black, fontWeight: FontWeight.w400),
    headlineLarge: TextStyle(fontSize: 15.sp, color: AppColors.black, fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(fontSize: 15.sp, color: AppColors.black, fontWeight: FontWeight.w500),
    headlineSmall: TextStyle(fontSize: 15.sp, color: AppColors.black, fontWeight: FontWeight.w400),
    titleLarge: TextStyle(fontSize: 14.sp, color: AppColors.black, fontWeight: FontWeight.w700),
    titleMedium: TextStyle(fontSize: 14.sp, color: AppColors.black, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 14.sp, color: AppColors.black, fontWeight: FontWeight.w400),
    bodyLarge: TextStyle(fontSize: 12.sp, color: AppColors.black, fontWeight: FontWeight.w700),
    bodyMedium: TextStyle(fontSize: 12.sp, color: AppColors.black, fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontSize: 12.sp, color: AppColors.black, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 10.sp, color: AppColors.black, fontWeight: FontWeight.w700),
    labelMedium: TextStyle(fontSize: 10.sp, color: AppColors.black, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 10.sp, color: AppColors.black, fontWeight: FontWeight.w400),
  );

  static final lightTheme = ThemeData(
    useMaterial3: false,
    textTheme: textTheme,
    dialogTheme: DialogThemeData(backgroundColor: AppColors.white),
    appBarTheme: AppBarTheme(backgroundColor: AppColors.white, elevation: 0),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors.scaffoldBackground),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    // fontFamily: FontFamily.aeonikPro,
    colorScheme: ColorScheme(
      // Background color
      primary: AppColors.primary,
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
    textTheme: textTheme,
    dialogTheme: DialogThemeData(backgroundColor: AppColors.white),
    appBarTheme: AppBarTheme(backgroundColor: AppColors.white, elevation: 0),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors.scaffoldDarkBackground),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.scaffoldDarkBackground,
    // fontFamily: FontFamily.aeonikPro,
    colorScheme: ColorScheme(
      // Background color
      primary: AppColors.primaryDark,
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
