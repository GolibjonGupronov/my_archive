import 'package:my_archive/core/enums/common.dart';

class StoryActionEntity {
  final String title;
  final StoryActionType type;
  final String actionData;

  StoryActionEntity({required this.title, required this.type, required this.actionData});
}
