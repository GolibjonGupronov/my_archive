import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_archive/core/exports/core_exports.dart';

class SessionShimmerItem extends StatelessWidget {
  const SessionShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomShimmer(
          child: BoxContainer(
            borderRadius: BorderRadius.circular(30.r),
            padding: EdgeInsets.all(8.w),
            child: Icon(Icons.apple, size: 30.w),
          ),
        ),
        12.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomShimmer(
                alignment: Alignment.centerLeft,
                child: TextView(DeviceService.deviceModel),
              ),
              2.height,
              CustomShimmer(
                alignment: Alignment.centerLeft,
                child: TextView(
                    "${Platform.operatingSystem.capitalize} ${DeviceService.packageInfo.version}, ${Platform.operatingSystem.capitalize} ${DeviceService.osVersion}",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
              2.height,
              CustomShimmer(
                alignment: Alignment.centerLeft,
                child: TextView("Tashkent, Uzbekistan", fontSize: 14.sp, color: AppColors.gray, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        8.width,
        CustomShimmer(alignment: Alignment.centerLeft, child: TextView("15/08", color: AppColors.gray))
      ],
    );
  }
}
