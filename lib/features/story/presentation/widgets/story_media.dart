import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/enums/common.dart';
import 'package:my_archive/core/exports/ui_exports.dart';
import 'package:my_archive/features/story/domain/entities/story_entity.dart';
import 'package:my_archive/features/story/presentation/bloc/story_bloc.dart';
import 'package:my_archive/features/story/presentation/bloc/story_state.dart';
import 'package:video_player/video_player.dart';

class StoryMedia extends StatelessWidget {
  final StoryEntity item;

  const StoryMedia({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    switch (item.resourceType) {
      case StoryFileType.image:
        return CustomImageView(pathOrUrl: item.resourceData, fit: BoxFit.cover);

      case StoryFileType.video:
        return BlocSelector<StoryBloc, StoryState, VideoPlayerController?>(
          selector: (state) => state.videoPlayerController,
          builder: (context, controller) {
            if (controller == null || !controller.value.isInitialized) {
              return CustomShimmer(
                  baseColor: AppColors.primary.withValues(alpha: .4),
                  highlightColor: AppColors.primary.withValues(alpha: .02),
                  radius: 0);
            }
            return SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: controller.value.size.width,
                  height: controller.value.size.height,
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                ),
              ),
            );
          },
        );

      case StoryFileType.none:
        return const SizedBox.shrink();
    }
  }
}
