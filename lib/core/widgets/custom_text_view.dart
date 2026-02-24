import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_archive/core/theme/app_theme.dart';

class CustomTextView extends StatelessWidget {
  final String body;
  final Color? textColor;
  final double? fontSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextStyle? style;
  final bool enableTabularFigures;
  final TextDecoration? textDecoration;
  final FontWeight? fontWeight;

  const CustomTextView(
    this.body, {
    super.key,
    this.textColor,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.style,
    this.textDecoration,
    this.fontWeight,
    this.enableTabularFigures = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      body,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: style ??
          AppTheme.textTheme.headlineSmall?.copyWith(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            decoration: textDecoration,
            fontFeatures: enableTabularFigures ? [const FontFeature.tabularFigures()] : null,
          ),
      textAlign: textAlign,
    );
  }
}
