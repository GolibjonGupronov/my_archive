import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/story/domain/entities/story_entity.dart';

class HomeState {
  final StateStatus storyStatus;
  final List<StoryEntity> storyList;
  final String errorMessage;

  HomeState({
    this.storyStatus = StateStatus.initial,
    this.storyList = const [],
    this.errorMessage = '',
  });

  HomeState copyWith({
    StateStatus? storyStatus,
    List<StoryEntity>? storyList,
    String? errorMessage,
  }) =>
      HomeState(
        storyStatus: storyStatus ?? this.storyStatus,
        storyList: storyList ?? this.storyList,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
