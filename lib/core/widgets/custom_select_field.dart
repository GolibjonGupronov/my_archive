import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/widgets/text_view.dart';

class CustomSelectField extends StatelessWidget {
  final String title;
  final String hint;
  final VoidCallback onTap;
  final String value;
  final String comment;
  final bool enabled;
  final String errorText;
  final Widget? rightWidget;
  final bool progress;

  const CustomSelectField(
    this.title,
    this.hint,
    this.onTap, {
    super.key,
    this.enabled = true,
    this.value = "",
    this.comment = "",
    this.errorText = "",
    this.rightWidget = const Icon(CupertinoIcons.chevron_down, color: AppColors.hint),
    this.progress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title.isNotEmpty)
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: title),
                ],
              ),
            ),
          if (title.isNotEmpty) 10.height,
          Container(
            decoration: BoxDecoration(
              color: AppColors.foregroundSecondary,
              border: errorText.isNotEmpty
                  ? Border.all(color: AppColors.red, width: 0.8)
                  : Border.all(color: AppColors.hint, width: 0.8),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16.r),
              onTap: () {
                if (enabled && !progress) {
                  onTap();
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                child: SizedBox(
                  child: Row(
                    children: [
                      Expanded(
                        child: value.isNotEmpty
                            ? TextView(value, fontWeight: FontWeight.w500)
                            : TextView(hint, color: AppColors.hint),
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
                  TextView(errorText, color: AppColors.red),
                ],
              ),
            ),
          if (comment.isNotEmpty)
            Container(
              padding: const EdgeInsets.only(top: 4),
              child: TextView(comment),
            ),
        ],
      ),
    );
  }
}
