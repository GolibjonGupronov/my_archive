import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';

class StoryListShimmer extends StatelessWidget {
  const StoryListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return CustomShimmer(width: 110.w,radius: 16.r,);
          },
          separatorBuilder: (c, i) => 12.width,
          itemCount: 5),
    );
  }
}
