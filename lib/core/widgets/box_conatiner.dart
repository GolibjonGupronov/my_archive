import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/constants/colors.dart';

class BoxContainer extends StatelessWidget {
  final Widget? child;
  final bool withShadow;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double? height;
  final double? width;
  final double? size;
  final Color? color;
  final BoxBorder? border;
  final BoxConstraints? constraints;
  final Gradient? gradient;
  final BoxShape shape;
  final Color? shadowColor;
  final double blurRadius;

  const BoxContainer({
    this.child,
    super.key,
    this.color,
    this.size,
    this.withShadow = false,
    this.borderRadius,
    this.padding,
    this.height,
    this.width,
    this.border,
    this.constraints,
    this.gradient,
    this.shadowColor,
    this.shape = BoxShape.rectangle,
    this.blurRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? width,
      height: size ?? height,
      constraints: constraints,
      decoration: BoxDecoration(
        boxShadow: withShadow
            ? [
                BoxShadow(
                  color: shadowColor ?? AppColors.shadow.withValues(alpha: 0.08),
                  spreadRadius: 1,
                  blurRadius: blurRadius,
                  offset: const Offset(1, 1),
                ),
              ]
            : [],
        color: gradient != null ? null : (color ?? AppColors.white),
        borderRadius: borderRadius,
        border: border,
        gradient: gradient,
        shape: shape,
      ),
      padding: padding,
      child: child,
    );
  }
}
