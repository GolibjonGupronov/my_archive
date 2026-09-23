import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/exports/ui_exports.dart';
import 'package:my_archive/features/media/domain/entities/media_entity.dart';

class MediaImage extends StatelessWidget {
  final MediaEntity item;

  const MediaImage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      padding: EdgeInsets.all(10.w),
      borderRadius: BorderRadius.circular(16.r),
      child: Row(
        children: [
          Stack(
            children: [
              CustomImageView(
                pathOrUrl: item.thumbnail,
                radius: 8.r,
                width: 80.w,
                height: 80.h,
                isBlur: true,
              ),
              Positioned(left: 0, right: 0, bottom: 0, top: 0, child: Icon(CupertinoIcons.cloud_download, color: AppColors.white))
            ],
          ),
          12.width,
          Expanded(child: TextView(item.title, maxLines: 2)),
        ],
      ),
    );
  }
}
