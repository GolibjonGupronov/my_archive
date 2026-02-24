import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:my_archive/core/enums/state_status.dart';

extension StateStateExtension on StateStatus {
  bool get isInitial => this == StateStatus.initial;

  bool get isInProgress => this == StateStatus.inProgress;

  bool get isSuccess => this == StateStatus.success;

  bool get isFailure => this == StateStatus.failure;

  bool get isCanceled => this == StateStatus.canceled;
}

extension HexColor on Color {
  String toHex({bool leadingHashSign = true, bool includeAlpha = true}) {
    final a = (this.a * 255).round();
    final r = (this.r * 255).round();
    final g = (this.g * 255).round();
    final b = (this.b * 255).round();

    return '${leadingHashSign ? '#' : ''}'
            '${includeAlpha ? a.toRadixString(16).padLeft(2, '0') : ''}'
            '${r.toRadixString(16).padLeft(2, '0')}'
            '${g.toRadixString(16).padLeft(2, '0')}'
            '${b.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }
}

extension CustomTime on TimeOfDay {
  String get formattedTime => "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
}

extension BuildContextExtensions on BuildContext {
  MediaQueryData get _mediaQuery => MediaQuery.of(this);

  EdgeInsets get safePadding => _mediaQuery.padding;
  EdgeInsets get viewInsets => _mediaQuery.viewInsets;
  Size get screenSize => _mediaQuery.size;

  double safeBottom([double extra = 0.0]) => safePadding.bottom + extra;

  double safeTop([double extra = 0.0]) => safePadding.top + extra;

  SizedBox safeBottomSpace([double extra = 0.0]) => SizedBox(height: safeBottom(extra));

  SizedBox safeTopSpace([double extra = 0.0]) => SizedBox(height: safeTop(extra));

  double get screenHeight => screenSize.height;
  double get screenWidth => screenSize.width;

  double get keyboardBottom => viewInsets.bottom;
  double get keyboardTop => viewInsets.top;

  bool get isDarkMode {
    final adaptiveMode = AdaptiveTheme.maybeOf(this)?.mode;
    if (adaptiveMode != null) {
      return adaptiveMode == AdaptiveThemeMode.dark;
    }
    return Theme.of(this).brightness == Brightness.dark;
  }
}
