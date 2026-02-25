import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/constants/gradients.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/widgets/text_view.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final VoidCallback? onClickDisabled;
  final bool active;
  final bool progress;
  final String? icon;
  final Color? fillColor;
  final Color? textColor;

  const CustomButton(
    this.text,
    this.onClick, {
    super.key,
    this.active = true,
    this.progress = false,
    this.icon,
    this.onClickDisabled,
    this.fillColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: ThemeData.fallback().splashColor,
      highlightColor: ThemeData.fallback().highlightColor,
      borderRadius: BorderRadius.circular(16.r),
      onTap: () {
        if (active && !progress) {
          onClick;
        } else if (!active && onClickDisabled != null) {
          onClickDisabled;
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: fillColor ?? (active ? AppColors.primary : AppColors.primary.withValues(alpha: 0.4)),
          gradient: fillColor == null && active ? Gradients.primaryGradient : null,
        ),
        child: Center(
          child: !progress
              ? icon != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(icon!, width: 18.w, height: 18.h, color: Colors.white),
                        4.width,
                        TextView(text, color: textColor ?? Colors.white, maxLines: 1),
                      ],
                    )
                  : TextView(text, color: textColor ?? Colors.white, maxLines: 1)
              : SizedBox(width: 16.w, height: 16.w, child: CupertinoActivityIndicator(color: Colors.white)),
        ),
      ),
    );
  }
}
