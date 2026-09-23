import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/exports/ui_exports.dart';
import 'package:my_archive/features/media/domain/entities/media_entity.dart';

class MediaFolder extends StatelessWidget {
  final MediaEntity item;
  final VoidCallback onTap;

  const MediaFolder({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: onTap,
      child: BoxContainer(
        padding: EdgeInsets.all(12.w),
        borderRadius: BorderRadius.circular(16.r),
        child: Row(
          children: [
            BoxContainer(
              width: 40.w,
              height: 40.h,
              shape: BoxShape.circle,
              color: AppColors.primary,
              child: Icon(CupertinoIcons.folder_fill, color: AppColors.white, size: 22.w),
            ),
            12.width,
            Expanded(child: TextView(item.title, maxLines: 2)),
            Icon(CupertinoIcons.chevron_forward)
          ],
        ),
      ),
    );
  }
}
