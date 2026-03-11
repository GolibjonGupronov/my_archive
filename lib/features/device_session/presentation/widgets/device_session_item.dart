import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/device_session/domain/entities/device_session_entity.dart';

class DeviceSessionItem extends StatelessWidget {
  final DeviceSessionEntity item;

  const DeviceSessionItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoxContainer(
            borderRadius: BorderRadius.circular(8.r),
            padding: EdgeInsets.all(4.w),
            color: AppColors.primary,
            child: Icon(item.operatingSystemType.icon, size: 30.w, color: AppColors.white)),
        12.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextView(item.deviceName),
              2.height,
              TextView(
                  "${item.operatingSystemType.title} ${item.appVersion}, ${item.operatingSystemType.title} ${item.releaseVersion} (${item.sdk})",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
              2.height,
              TextView(item.address, fontSize: 14.sp, color: AppColors.gray, fontWeight: FontWeight.w400),
            ],
          ),
        ),
        8.width,
        TextView(item.dateTime, color: AppColors.gray)
      ],
    );
  }
}
