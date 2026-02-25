import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/widgets/text_view.dart';

class ComingSoonWidget extends StatelessWidget {
  final Widget child;
  final bool isSoon;
  final BorderRadius? borderRadius;

  const ComingSoonWidget({
    super.key,
    required this.child,
    this.isSoon = true,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: isSoon ? 3 : 0, sigmaY: isSoon ? 3 : 0),
          child: AbsorbPointer(
            absorbing: isSoon,
            child: child,
          ),
        ),
        if (isSoon)
          ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(8.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: borderRadius ?? BorderRadius.circular(8.r),
                  color: AppColors.gray.withValues(alpha: 0.2),
                ),
                child: CustomTextView(tr('soon')),
              ),
            ),
          ),
      ],
    );
  }
}
