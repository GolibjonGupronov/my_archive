import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';

class FaqShimmerItem extends StatefulWidget {
  const FaqShimmerItem({super.key});

  @override
  State<FaqShimmerItem> createState() => _FaqShimmerItemState();
}

class _FaqShimmerItemState extends State<FaqShimmerItem> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: BoxContainer(
        borderRadius: BorderRadius.circular(16.r),
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: TextView("\n")),
                Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.gray),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
