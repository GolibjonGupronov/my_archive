import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_archive/core/di/injection_container.dart';
import 'package:my_archive/core/exports/ui_exports.dart';
import 'package:my_archive/core/utils/logger.dart';
import 'package:my_archive/features/story/domain/entities/story_action_entity.dart';
import 'package:my_archive/features/story/domain/entities/story_entity.dart';
import 'package:my_archive/features/story/presentation/bloc/story_bloc.dart';
import 'package:my_archive/features/story/presentation/bloc/story_event.dart';
import 'package:my_archive/features/story/presentation/bloc/story_state.dart';
import 'package:my_archive/features/story/presentation/widgets/story_media.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StoryPage extends StatelessWidget {
  final List<StoryEntity> storyList;
  final int activeIndex;
  final Function(StoryEntity item) itemCheck;

  const StoryPage({super.key, required this.storyList, required this.activeIndex, required this.itemCheck});

  static const String tag = '/story_page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoryBloc(
          storyList: storyList,
          currentIndex: activeIndex,
          pageController: PageController(initialPage: activeIndex),
          readStoryUseCase: sl(),
          onItemRead: (item) => itemCheck(item),
          prepareStoryVideoUseCase: sl())
        ..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    logger("GGQ => StoryPage");
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
                                child: StoryMedia(item: item),
                              ),
                            ),
                            if (item.action != null)
                              Positioned(
                                left: 16.w,
                                right: 16.w,
                                bottom: 20.h,
                                child: SafeArea(
                                  child: CustomButton(
                                    item.action!.title,
                                    () => switch (item.action!.type) {
                                      StoryActionType.link => openUrl(item.action!.actionData),
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ))
                    .toList(),
              )),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 100.h,
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
              ),
              const _TopBar(),
            ],
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

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 10.h,
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
                                barRadius: Radius.circular(24.r),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
            16.height,
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: InkWell(
                  onTap: () => context.pop(),
                  child: Icon(
                    CupertinoIcons.clear,
                    size: 32.w,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
