abstract class StoryEvent {}

class InitEvent extends StoryEvent {}

class PauseTimerEvent extends StoryEvent {}

class PlayTimerEvent extends StoryEvent {}

class FinishPageEvent extends StoryEvent {}

class NextPageEvent extends StoryEvent {}

class PreviousPageEvent extends StoryEvent {}

class ReadStoryEvent extends StoryEvent {}

class UpdateIndicatorEvent extends StoryEvent {
  final int indicatorProgress;

  UpdateIndicatorEvent({required this.indicatorProgress});
}

class UpdatedActivePageEvent extends StoryEvent {
  final int index;

  UpdatedActivePageEvent({required this.index});
}

class VideoPrepareFailedEvent extends StoryEvent {
  final String message;

  VideoPrepareFailedEvent({required this.message});
}

class AppLifecyclePausedEvent extends StoryEvent {}

class AppLifecycleResumedEvent extends StoryEvent {}
