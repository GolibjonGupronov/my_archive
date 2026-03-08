enum StoryActionType {
  link;

  static StoryActionType getObj(String key) => switch (key) {
        'link' => StoryActionType.link,
        _ => StoryActionType.link,
      };

  String get key => switch (this) {
        StoryActionType.link => 'link',
      };
}

class StoryActionEntity {
  final String title;
  final StoryActionType type;
  final String actionData;

  StoryActionEntity({required this.title, required this.type, required this.actionData});
}
