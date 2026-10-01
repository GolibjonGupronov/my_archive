import 'package:my_archive/features/story/domain/entities/story_action_entity.dart';

class StoryActionModel extends StoryActionEntity {
  StoryActionModel({required super.title, required super.type, required super.actionData});

  factory StoryActionModel.fromJson(Map<String, dynamic> json) {
    return StoryActionModel(
      title: json['title'] as String,
      type: StoryActionType.getObj(json['type'] as String),
      actionData: json['action_data'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type.key,
      'action_data': actionData,
    };
  }
}
