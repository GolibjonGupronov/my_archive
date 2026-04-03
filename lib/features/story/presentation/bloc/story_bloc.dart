import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:my_archive/features/story/domain/entities/story_entity.dart';
import 'package:my_archive/features/story/domain/use_cases/read_story_use_case.dart';
import 'package:my_archive/features/story/presentation/bloc/story_event.dart';
import 'package:my_archive/features/story/presentation/bloc/story_state.dart';
import 'package:video_player/video_player.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final PageController pageController;
  final List<StoryEntity> storyList;
  int currentIndex;
  Timer? _videoTimer;
  final List<int> _progressList;
  bool _pausedByLifecycle = false;

  late final AppLifecycleListener _lifecycleListener;

  final ReadStoryUseCase readStoryUseCase;

  StoryBloc({
    required this.storyList,
    required this.currentIndex,
    required this.pageController,
    required this.readStoryUseCase,
  })  : _progressList = List.filled(storyList.length, 0),
        super(const StoryState()) {
    on<InitEvent>((event, emit) {
      add(UpdatedActivePageEvent(index: currentIndex));
    });

    on<PauseTimerEvent>((event, emit) {
      _pauseVideo();
      emit(state.copyWith(isPaused: true));
    });

    on<PlayTimerEvent>((event, emit) {
      if (_pausedByLifecycle) return;
      _resumeVideo();
      emit(state.copyWith(isPaused: false));
    });

    on<UpdatedActivePageEvent>(_onUpdatedActivePage);

    on<ReadStoryEvent>((event, emit) {
      final item = storyList[currentIndex];
      if (!item.isRead) readStoryUseCase.callUseCase(item.id);
    });

    on<FinishPageEvent>((event, emit) {
      _stopTimer();
      emit(state.copyWith(isFinishStory: true));
    });

    on<PreviousPageEvent>((event, emit) {
      if (!state.isFirstPage) {
        _progressList[currentIndex] = 0;
        pageController.previousPage(
          duration: const Duration(milliseconds: 10),
          curve: Curves.easeIn,
        );
      }
    });
    on<NextPageEvent>((event, emit) {
      if (state.isLastPage) {
        add(FinishPageEvent());
      } else {
        _progressList[currentIndex] = 0;
        pageController.nextPage(
          duration: const Duration(milliseconds: 10),
          curve: Curves.easeIn,
        );
      }
    });
    on<UpdateIndicatorEvent>((event, emit) {
      emit(state.copyWith(indicatorProgress: event.indicatorProgress));
    });

    on<AppLifecyclePausedEvent>((event, emit) {
      if (_pausedByLifecycle) return;
      _pausedByLifecycle = true;
      _pauseVideo();
      emit(state.copyWith(isPaused: true));
    });

    on<AppLifecycleResumedEvent>((event, emit) {
      if (!_pausedByLifecycle) return;
      _pausedByLifecycle = false;
      _resumeVideo();
      emit(state.copyWith(isPaused: false));
    });

    _lifecycleListener = AppLifecycleListener(
      onHide: () => add(AppLifecyclePausedEvent()),
      onPause: () => add(AppLifecyclePausedEvent()),
      onInactive: () => add(AppLifecyclePausedEvent()),
      onShow: () => add(AppLifecycleResumedEvent()),
      onResume: () => add(AppLifecycleResumedEvent()),
    );
  }

  Future<void> _onUpdatedActivePage(UpdatedActivePageEvent event, Emitter<StoryState> emit) async {
    currentIndex = event.index;

    final oldController = state.videoPlayerController;
    oldController?.pause();
    emit(state.copyWith(
      videoPlayerController: null,
      isFirstPage: currentIndex == 0,
      isLastPage: currentIndex == storyList.length - 1,
      indicatorProgress: _progressList[currentIndex],
      isPaused: false,
    ));
    await oldController?.dispose();

    final item = storyList[currentIndex];

    if (item.resourceType == StoryFileType.video) {
      final controller = VideoPlayerController.networkUrl(Uri.parse(item.resourceData));
      await controller.initialize();
      if (isClosed) {
        await controller.dispose();
        return;
      }

      emit(state.copyWith(videoPlayerController: controller));
      if (!state.isPaused) controller.play();
    }

    add(ReadStoryEvent());
    _initTimer();
  }

  void _initTimer() {
    _stopTimer();
    _videoTimer = Timer.periodic(const Duration(milliseconds: 100), (_) => _onTick());
  }

  void _stopTimer() {
    _videoTimer?.cancel();
    _videoTimer = null;
  }

  void _onTick() {
    if (state.isPaused) return;

    final currentStory = storyList[currentIndex];
    int progress = _progressList[currentIndex];

    if (currentStory.resourceType == StoryFileType.video) {
      final controller = state.videoPlayerController;
      if (controller?.value.isInitialized == true) {
        final duration = controller!.value.duration.inMilliseconds;
        if (duration > 0) {
          progress = (controller.value.position.inMilliseconds * 100 ~/ duration);
        }
      }
    } else {
      progress = (progress + 1).clamp(0, 100);
    }

    _progressList[currentIndex] = progress;

    if (progress >= 100) {
      _progressList[currentIndex] = 0;
      _stopTimer();
      if (currentIndex == storyList.length - 1) {
        add(FinishPageEvent());
      } else {
        add(NextPageEvent());
      }
      return;
    }

    add(UpdateIndicatorEvent(indicatorProgress: progress));
  }

  void _resumeVideo() {
    if (storyList[currentIndex].resourceType == StoryFileType.video) {
      state.videoPlayerController?.play();
    }
  }

  void _pauseVideo() {
    if (storyList[currentIndex].resourceType == StoryFileType.video) {
      state.videoPlayerController?.pause();
    }
  }

  @override
  Future<void> close() async {
    _lifecycleListener.dispose();
    _stopTimer();
    pageController.dispose();
    await state.videoPlayerController?.pause();
    await state.videoPlayerController?.dispose();
    return super.close();
  }
}
