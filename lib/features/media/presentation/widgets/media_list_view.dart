import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/exports/ui_exports.dart';
import 'package:my_archive/features/media/domain/entities/media_entity.dart';
import 'package:my_archive/features/media/presentation/widgets/media_item.dart';

class MediaListView extends StatelessWidget {
  final List<MediaEntity> mediaList;

  const MediaListView({super.key, required this.mediaList});

  @override
  Widget build(BuildContext context) {
    return mediaList.isEmpty
        ? Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.folder_fill, size: 80.w),
              12.height,
              TextView("Hech narsa yo'q"),
            ],
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ListView.separated(
                padding: EdgeInsets.only(bottom: 100.h),
                itemBuilder: (context, index) {
                  final item = mediaList[index];
                  return MediaItem(item: item);
                },
                itemCount: mediaList.length,
                separatorBuilder: (context, index) => 10.height),
          );
  }
}
