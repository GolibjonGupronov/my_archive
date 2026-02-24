import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/widgets/custom_text_view.dart';

class CustomSelectField extends StatelessWidget {
  final String title;
  final String hint;
  final Function onTap;
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
                  TextSpan(
                    text: title,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
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
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                if (enabled && !progress) {
                  onTap();
                }
              },
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      child: SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                              child: value.isNotEmpty
                                  ? CustomTextView(value, fontSize: 16, fontWeight: FontWeight.w500)
                                  : CustomTextView(hint, textColor: AppColors.hint),
                            ),
                            if (rightWidget != null || progress)
                              progress
                                  ? const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: CupertinoActivityIndicator(radius: 10),
                                      ),
                                    )
                                  : rightWidget!,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (errorText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const Icon(Icons.clear_rounded, color: AppColors.red, size: 18),
                  4.width,
                  Text(
                    errorText,
                    style: const TextStyle(
                      color: AppColors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          if (comment.isNotEmpty)
            Container(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                comment,
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
