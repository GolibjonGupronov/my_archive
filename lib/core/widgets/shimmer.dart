import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? size;
  final double? radius;
  final Widget? child;
  final Alignment? alignment;

  const CustomShimmer({super.key, this.child, this.height, this.width, this.size, this.radius, this.alignment});

  @override
  Widget build(BuildContext context) {
    final shimmer = Shimmer.fromColors(
      baseColor: AppColors.gray.withValues(alpha: .2),
      highlightColor: AppColors.gray.withValues(alpha: .02),
      period: Duration(seconds: 4),
      child: BoxContainer(
        height: size ?? height,
        width: size ?? width,
        borderRadius: BorderRadius.circular(radius ?? 60.r),
        color: AppColors.black,
        child: child ?? SizedBox(),
      ),
    );

    if (alignment != null) {
      return Align(
        alignment: alignment!,
        child: shimmer,
      );
    }

    return shimmer;
  }
}
