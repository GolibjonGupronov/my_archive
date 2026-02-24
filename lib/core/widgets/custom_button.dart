import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/constants/gradients.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/widgets/custom_text_view.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function onClick;
  final Function? onClickDisabled;
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
  State<StatefulWidget> createState() {
    return CustomButtonState();
  }
}

class CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: ThemeData.fallback().splashColor,
      highlightColor: ThemeData.fallback().highlightColor,
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        if (widget.active && !widget.progress) {
          widget.onClick();
        } else if (!widget.active && widget.onClickDisabled != null) {
          widget.onClickDisabled!();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: widget.fillColor ?? (widget.active ? AppColors.primary : AppColors.primary.withValues(alpha: 0.4)),
          gradient: widget.fillColor != null
              ? null
              : widget.active
                  ? Gradients.primaryGradient
                  : null,
        ),
        child: Center(
          child: !widget.progress
              ? widget.icon != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          widget.icon!,
                          width: 18,
                          height: 18,
                          color: Colors.white,
                        ),
                        4.width,
                        CustomTextView(widget.text, textColor: widget.textColor ?? Colors.white, maxLines: 1),
                      ],
                    )
                  : CustomTextView(widget.text, textColor: widget.textColor ?? Colors.white, maxLines: 1)
              : SizedBox(width: 16.w, height: 16.w, child: CupertinoActivityIndicator(color: Colors.white)),
        ),
      ),
    );
  }
}
