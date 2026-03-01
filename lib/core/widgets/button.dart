import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final VoidCallback? onClickDisabled;
  final bool active;
  final bool progress;
  final Gradient? gradient;
  final IconData? icon;
  final Color? fillColor;
  final Color? textColor;
  final String? toastMessage;

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
    this.gradient,
    this.toastMessage,
  });

  @override
  Widget build(BuildContext context) {
    final toast = toastMessage ?? "Ma'lumotlarni to'ldiring";
    return Bounce(
      onTap: () {
        if (active && !progress) {
          onClick.call();
        } else if (!active && onClickDisabled != null) {
          onClickDisabled?.call();
        } else if (!active && toast.isNotEmpty) {
          showInfoToast(context, toast, second: 1);
        }
      },
      child: Container(
        height: 52.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: fillColor ?? (active ? AppColors.primary : AppColors.primary.withValues(alpha: 0.4)),
          gradient: fillColor == null && active ? gradient ?? Gradients.primaryGradient : null,
        ),
        child: Center(
          child: !progress
              ? icon != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(icon!, size: 24.h, color: Colors.white),
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
