import 'package:flutter/material.dart';
import 'package:my_archive/core/constants/colors.dart';

class Gradients {
  static LinearGradient get primaryGradient => LinearGradient(
        colors: [AppColors.gradientPrimaryStart, AppColors.gradientPrimaryEnd],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      );

  static LinearGradient get redGradient => LinearGradient(
        colors: [AppColors.gradientRedStart, AppColors.gradientRedEnd],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      );

  static LinearGradient get orangeGradient => LinearGradient(
        colors: [AppColors.gradientOrangeStart, AppColors.gradientOrangeEnd],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      );

  static LinearGradient get greenGradient => LinearGradient(
        colors: [AppColors.gradientGreenStart, AppColors.gradientGreenEnd],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      );
}
