import 'dart:io';

enum BottomNavMainPage { home, profile }

enum NextPage { auth, main, update }

enum Gender {
  male,
  female;

  static Gender getObj(String key) => switch (key) {
        'male' => Gender.male,
        'female' => Gender.female,
        _ => Gender.male,
      };

  String get key => switch (this) {
        Gender.male => "male",
        Gender.female => "female",
      };
}

enum LangType {
  uz,
  ru;

  static LangType getObj(String key) => switch (key) {
        'uz' => LangType.uz,
        'ru' => LangType.ru,
        _ => LangType.uz,
      };

  String get key => switch (this) {
        LangType.uz => 'uz',
        LangType.ru => 'ru',
      };

  LangType get next {
    final index = LangType.values.indexOf(this);
    final nextIndex = (index + 1) % LangType.values.length;
    return LangType.values[nextIndex];
  }
}

enum OperatingSystemType {
  android,
  ios;

  static OperatingSystemType getObj(String key) => switch (key) {
        'android' => OperatingSystemType.android,
        'ios' => OperatingSystemType.ios,
        _ => OperatingSystemType.android,
      };

  String get key => switch (this) {
        OperatingSystemType.android => 'android',
        OperatingSystemType.ios => 'ios',
      };

  static OperatingSystemType get current => Platform.isIOS ? OperatingSystemType.ios : OperatingSystemType.android;
}

enum AutoLockTimeType {
  immediately,
  after5Seconds,
  after10Seconds,
  after30Seconds,
  after1Minute,
  after5Minutes,
  after10Minutes,
  after30Minutes,
  after1Hour,
  disable;

  static AutoLockTimeType getObj(String key) => AutoLockTimeType.values.firstWhere((e) => e.name == key);

  String get key => name;

  int get seconds => switch (this) {
        AutoLockTimeType.immediately => 0,
        AutoLockTimeType.after5Seconds => 5,
        AutoLockTimeType.after10Seconds => 10,
        AutoLockTimeType.after30Seconds => 30,
        AutoLockTimeType.after1Minute => 60,
        AutoLockTimeType.after5Minutes => 5 * 60,
        AutoLockTimeType.after10Minutes => 10 * 60,
        AutoLockTimeType.after30Minutes => 30 * 60,
        AutoLockTimeType.after1Hour => 60 * 60,
        AutoLockTimeType.disable => -1,
      };
}

enum ByteUnit {
  b(1, "B"),
  kb(1024, "KB"),
  mb(1024 * 1024, "MB"),
  gb(1024 * 1024 * 1024, "GB"),
  tb(1024 * 1024 * 1024 * 1024, "TB"),
  pb(1024 * 1024 * 1024 * 1024 * 1024, "PB");

  final num multiplier;
  final String label;

  const ByteUnit(this.multiplier, this.label);
}

enum FolderType {
  video,
  audio,
  image,
  file;

  String get key => switch (this) {
        FolderType.video => 'videos',
        FolderType.audio => 'audios',
        FolderType.image => 'images',
        FolderType.file => 'files',
      };
}

enum MediaType {
  video,
  audio,
  image,
  file,
  folder,
  none;

  static MediaType getObj(String key) => switch (key) {
    'video' => MediaType.video,
    'audio' => MediaType.audio,
    'image' => MediaType.image,
    'file' => MediaType.file,
    'folder' => MediaType.folder,
    _ => MediaType.none,
  };

  String get key => switch (this) {
    MediaType.video => 'video',
    MediaType.audio => 'audio',
    MediaType.image => 'image',
    MediaType.file => 'file',
    MediaType.folder => 'folder',
    MediaType.none => 'none',
  };
}