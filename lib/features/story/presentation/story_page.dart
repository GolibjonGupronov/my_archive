import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/story/domain/entities/story_action_entity.dart';
import 'package:my_archive/features/story/domain/entities/story_entity.dart';
import 'package:my_archive/features/story/presentation/bloc/story_bloc.dart';
import 'package:my_archive/features/story/presentation/bloc/story_event.dart';
import 'package:my_archive/features/story/presentation/bloc/story_state.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';

class StoryPage extends StatefulWidget {
  final List<StoryEntity> storyList;
  final int activeIndex;
  final Function(StoryEntity item) itemCheck;

  const StoryPage({super.key, required this.storyList, required this.activeIndex, required this.itemCheck});

  static const String tag = '/story_page';

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  void initState() {
    super.initState();
    widget.itemCheck(widget.storyList[widget.activeIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoryBloc(
          storyList: widget.storyList,
          currentIndex: widget.activeIndex,
          pageController: PageController(initialPage: widget.activeIndex))
        ..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<StoryBloc>(context);

    return BlocListener<StoryBloc, StoryState>(
      listenWhen: (prev, curr) => prev.isFinishStory != curr.isFinishStory,
      listener: (context, state) {
        if (state.isFinishStory) context.pop();
      },
      child: CustomScaffold(
        body: GestureDetector(
          onTapDown: (details) {
            bloc.add(PauseTimerEvent());
            final dx = details.globalPosition.dx;
            final width = MediaQuery.sizeOf(context).width;
            if (dx < 100) {
              bloc.add(PreviousPageEvent());
            } else if (dx > width - 100) {
              bloc.add(NextPageEvent());
            }
          },
          onTapUp: (_) => bloc.add(PlayTimerEvent()),
          child: Stack(
            children: [
              Positioned.fill(
                  child: PageView(
                controller: bloc.pageController,
                onPageChanged: (index) {
                  final item = bloc.storyList[index];
                  widget.itemCheck(item);
                  bloc.add(UpdatedActivePageEvent(index: index));
                },
                children: bloc.storyList
                    .mapIndexed((index, item) => Stack(
                          children: [
                            Positioned.fill(
                              child: ImageFiltered(
                                imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: CustomImageView(
                                  pathOrUrl: item.thumbnail,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: IgnorePointer(
                                child: _StoryMedia(item: item),
                              ),
                            ),
                            if (item.action != null)
                              Positioned(
                                left: 16,
                                right: 16,
                                bottom: context.safeBottom(10),
                                child: CustomButton(
                                  item.action!.title,
                                  () => switch (item.action!.type) {
                                    StoryActionType.link => openUrl(item.action!.actionData),
                                  },
                                ),
                              ),
                          ],
                        ))
                    .toList(),
              )),
              const _TopGradient(),
              const _TopBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoryMedia extends StatelessWidget {
  final StoryEntity item;

  const _StoryMedia({required this.item});

  @override
  Widget build(BuildContext context) {
    switch (item.resourceType) {
      case StoryFileType.image:
        return CustomImageView(pathOrUrl: item.resourceData, fit: BoxFit.cover);

      case StoryFileType.video:
        return BlocSelector<StoryBloc, StoryState, VideoPlayerController?>(
          selector: (state) => state.videoPlayerController,
          builder: (context, controller) {
            if (controller?.value.isInitialized != true) {
              return const Center(child: CupertinoActivityIndicator());
            }
            return Stack(
              children: [
                _VideoPlayerWidget(controller: controller!, fit: BoxFit.cover, blur: 15),
                _VideoPlayerWidget(controller: controller, fit: BoxFit.contain, blur: 0),
              ],
            );
          },
        );

      case StoryFileType.none:
        return const SizedBox.shrink();
    }
  }
}

class _VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final BoxFit fit;
  final double blur;

  const _VideoPlayerWidget({
    required this.controller,
    required this.fit,
    required this.blur,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        fit: fit,
        child: SizedBox(
          width: controller.value.size.width,
          height: controller.value.size.height,
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: VideoPlayer(controller),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopGradient extends StatelessWidget {
  const _TopGradient();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: context.safeTop(100),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.black.withValues(alpha: 0.5),
              AppColors.black.withValues(alpha: 0.4),
              AppColors.black.withValues(alpha: 0.3),
              AppColors.black.withValues(alpha: 0.2),
              AppColors.black.withValues(alpha: 0.1),
              AppColors.black.withValues(alpha: 0.0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StoryBloc>();

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: context.safeTop(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 4,
            child: BlocBuilder<StoryBloc, StoryState>(
              buildWhen: (prev, curr) =>
                  prev.indicatorProgress != curr.indicatorProgress || prev.currentIndex != curr.currentIndex,
              builder: (context, state) {
                return Row(
                  children: bloc.storyList
                      .mapIndexed(
                        (index, _) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: index == bloc.storyList.length - 1 ? 0 : 8,
                            ),
                            child: LinearPercentIndicator(
                              animation: true,
                              backgroundColor: AppColors.white.withValues(alpha: 0.3),
                              progressColor: AppColors.white,
                              padding: EdgeInsets.zero,
                              animateFromLastPercent: true,
                              animationDuration: 100,
                              lineHeight: 4,
                              percent: bloc.currentIndex > index
                                  ? 1.0
                                  : (bloc.currentIndex == index ? state.indicatorProgress : 0) / 100.0,
                              barRadius: const Radius.circular(24),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: InkWell(
                onTap: () => context.pop(),
                child: const Icon(
                  CupertinoIcons.clear,
                  size: 32,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
