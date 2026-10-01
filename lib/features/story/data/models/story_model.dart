import 'package:my_archive/features/story/data/models/story_action_model.dart';
import 'package:my_archive/features/story/domain/entities/story_entity.dart';

class StoryModel extends StoryEntity {
  StoryModel({
    required super.id,
    required super.title,
    required super.thumbnail,
    required super.resourceData,
    required super.resourceType,
    required StoryActionModel? super.action,
    required super.isRead,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'] as int,
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
      resourceData: json['resource_data'] as String,
      resourceType: StoryFileType.getObj(json['resource_type'] as String),
      action: json['action'] == null ? null : StoryActionModel.fromJson(json['action'] as Map<String, dynamic>),
      isRead: json['is_read'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'resource_data': resourceData,
      'resource_type': resourceType.key,
      'action': (action as StoryActionModel?)?.toJson(),
      'is_read': isRead,
    };
  }
}
