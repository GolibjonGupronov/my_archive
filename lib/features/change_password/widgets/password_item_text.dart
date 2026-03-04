import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';

class PasswordItemText extends StatelessWidget {
  final bool isActive;
  final String text;

  const PasswordItemText({super.key, required this.isActive, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          isActive
              ? Icon(CupertinoIcons.checkmark_alt_circle_fill, color: AppColors.primary)
              : Icon(CupertinoIcons.clear_circled_solid, color: AppColors.red),
          8.width,
          Expanded(
            child: TextView(text, color: isActive ? AppColors.primary : AppColors.gray),
          ),
        ],
      ),
    );
  }
}
