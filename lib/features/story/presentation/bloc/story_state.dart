import 'package:video_player/video_player.dart';

class StoryState {
  final int currentIndex;
  final bool isFinishStory;
  final VideoPlayerController? videoPlayerController;
  final bool isFirstPage;
  final bool isLastPage;
  final int indicatorProgress;
  final bool isPaused;

  const StoryState({
    this.currentIndex = -1,
    this.isFinishStory = false,
    this.videoPlayerController,
    this.isFirstPage = false,
    this.isLastPage = false,
    this.indicatorProgress = 0,
    this.isPaused = false,
  });

  StoryState copyWith({
    int? currentIndex,
    bool? isFinishStory,
    Object? videoPlayerController = _sentinel,
    bool? isFirstPage,
    bool? isLastPage,
    int? indicatorProgress,
    bool? isPaused,
  }) =>
      StoryState(
        currentIndex: currentIndex ?? this.currentIndex,
        isFinishStory: isFinishStory ?? this.isFinishStory,
        videoPlayerController:
            videoPlayerController == _sentinel ? this.videoPlayerController : videoPlayerController as VideoPlayerController?,
        isFirstPage: isFirstPage ?? this.isFirstPage,
        isLastPage: isLastPage ?? this.isLastPage,
        indicatorProgress: indicatorProgress ?? this.indicatorProgress,
        isPaused: isPaused ?? this.isPaused,
      );
}

const Object _sentinel = Object();
