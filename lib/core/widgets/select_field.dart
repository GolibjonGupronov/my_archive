import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/extensions/common.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/theme/app_theme.dart';
import 'package:my_archive/core/widgets/bounce.dart';
import 'package:my_archive/core/widgets/text_view.dart';

class CustomSelectField extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final String hint;
  final VoidCallback onTap;
  final String value;
  final String comment;
  final bool enabled;
  final String errorText;
  final Widget? rightWidget;
  final bool progress;
  final bool required;

  const CustomSelectField(
    this.title,
    this.hint,
    this.onTap, {
    super.key,
    this.enabled = true,
    this.value = "",
    this.comment = "",
    this.errorText = "",
    this.required = false,
    this.rightWidget = const Icon(CupertinoIcons.chevron_down, color: AppColors.hint, size: 22),
    this.progress = false,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title.isNotEmpty) ...[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: titleStyle ??
                        AppTheme.textTheme.headlineMedium
                            ?.copyWith(color: context.isDarkModeEnable ? AppColors.white : AppColors.black),
                  ),
                  if (required)
                    TextSpan(
                      text: " *",
                      style: AppTheme.textTheme.headlineMedium?.copyWith(color: AppColors.red),
                    ),
                ],
              ),
            ),
            10.height
          ],
          Bounce(
            onTap: () {
              if (enabled && !progress) {
                onTap();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: context.isDarkModeEnable ? AppColors.whiteDark : AppColors.foregroundSecondary,
                border: errorText.isNotEmpty ? Border.all(color: AppColors.red, width: 0.8) : null,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: SizedBox(
                height: 60.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: value.isNotEmpty
                            ? CustomTextView(value, fontWeight: FontWeight.w500)
                            : CustomTextView(hint, color: AppColors.hint, fontWeight: FontWeight.w400),
                      ),
                      if (rightWidget != null || progress)
                        progress
                            ? Center(
                                child: Padding(padding: EdgeInsets.all(2.w), child: CupertinoActivityIndicator(radius: 10.r)))
                            : rightWidget!,
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (errorText.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 10.w),
              child: Row(
                children: [
                  Icon(Icons.clear_rounded, color: AppColors.red, size: 18.w),
                  4.width,
                  CustomTextView(errorText, color: AppColors.red),
                ],
              ),
            ),
          if (comment.isNotEmpty) ...[
            4.height,
            CustomTextView(
              comment,
              fontWeight: FontWeight.w400,
              color: AppColors.gray,
            )
          ],
        ],
      ),
    );
  }
}
