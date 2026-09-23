import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/exports/ui_exports.dart';
import 'package:my_archive/features/media/domain/entities/media_entity.dart';

class MediaFile extends StatelessWidget {
  final MediaEntity item;

  const MediaFile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      padding: EdgeInsets.all(12.w),
      borderRadius: BorderRadius.circular(16.r),
      child: Row(
        children: [
          BoxContainer(
            width: 40.w,
            height: 40.h,
            shape: BoxShape.circle,
            color: AppColors.primary,
            child: Icon(CupertinoIcons.doc_fill, color: AppColors.white, size: 22.w),
          ),
          12.width,
          Expanded(child: TextView(item.title, maxLines: 2)),
        ],
      ),
    );
  }
}
