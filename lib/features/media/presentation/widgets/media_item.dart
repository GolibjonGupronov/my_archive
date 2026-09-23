import 'package:flutter/cupertino.dart';
import 'package:my_archive/core/exports/ui_exports.dart';
import 'package:my_archive/features/media/domain/entities/media_entity.dart';
import 'package:my_archive/features/media/presentation/widgets/media_audio.dart';
import 'package:my_archive/features/media/presentation/widgets/media_file.dart';
import 'package:my_archive/features/media/presentation/widgets/media_folder.dart';
import 'package:my_archive/features/media/presentation/widgets/media_image.dart';
import 'package:my_archive/features/media/presentation/widgets/media_none.dart';
import 'package:my_archive/features/media/presentation/widgets/media_video.dart';

class MediaItem extends StatelessWidget {
  final MediaEntity item;

  const MediaItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return switch (item.type) {
      MediaType.folder => MediaFolder(item: item, onTap: () {}),
      MediaType.video => MediaVideo(item: item),
      MediaType.image => MediaImage(item: item),
      MediaType.audio => MediaAudio(item: item),
      MediaType.file => MediaFile(item: item),
      MediaType.none => MediaNone(item: item),
    };
  }
}
