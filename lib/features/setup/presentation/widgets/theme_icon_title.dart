import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:my_archive/core/core_exports.dart';

class ThemeIconTitle extends StatelessWidget {
  final AdaptiveThemeMode themeMode;
  final AdaptiveThemeMode currentMode;

  const ThemeIconTitle({super.key, required this.themeMode, required this.currentMode});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
            themeMode.isSystem
                ? Icons.system_security_update_warning_rounded
                : themeMode.isDark
                    ? Icons.dark_mode
                    : Icons.light_mode,
            color: currentMode == themeMode ? AppColors.primary : AppColors.gray),
        12.width,
        Expanded(
          child: TextView(
            themeMode.isSystem
                ? "Tizim rejimi"
                : themeMode.isDark
                    ? "Tungi rejim"
                    : "Kunguzgi rejim",
            fontWeight: currentMode == themeMode ? FontWeight.w600 : FontWeight.w400,
            color: currentMode == themeMode ? AppColors.primary : AppColors.gray,
          ),
        )
      ],
    );
  }
}
