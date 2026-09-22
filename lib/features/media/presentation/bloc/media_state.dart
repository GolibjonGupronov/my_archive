import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/features/media/domain/entities/media_entity.dart';

class MediaState {
  final StateStatus mediaStatus;
  final List<MediaEntity> mediaList;
  final String errorMessage;

  const MediaState({
    this.mediaStatus = StateStatus.initial,
    this.mediaList = const [],
    this.errorMessage = '',
  });

  MediaState copyWith({
    StateStatus? mediaStatus,
    List<MediaEntity>? mediaList,
    String? errorMessage,
  }) =>
      MediaState(
        mediaStatus: mediaStatus ?? this.mediaStatus,
        mediaList: mediaList ?? this.mediaList,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
