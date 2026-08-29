import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/core/exports/route_exports.dart';

enum BottomNavMainPage { home, profile }

enum NextPage {
  auth,
  main,
  update;

  String get page => switch (this) {
        NextPage.auth => LoginPage.tag,
        NextPage.main => MainPage.tag,
        NextPage.update => UpdatePage.tag,
      };
}

enum Gender {
  male,
  female;

  static Gender getObj(String key) => switch (key) {
        'male' => Gender.male,
        'female' => Gender.female,
        _ => Gender.male,
      };

  String get title => switch (this) {
        Gender.male => tr('male'),
        Gender.female => tr('female'),
      };

  String get key => switch (this) {
        Gender.male => "male",
        Gender.female => "female",
      };

  SvgGenImage get iconSvg => switch (this) {
        Gender.male => Assets.icons.male,
        Gender.female => Assets.icons.female,
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

  Locale get locale => switch (this) {
        LangType.uz => Locale('uz'),
        LangType.ru => Locale('ru'),
      };

  String get title => switch (this) {
        LangType.uz => "O'zbek",
        LangType.ru => "Русский",
      };

  SvgGenImage get iconSvg => switch (this) {
        LangType.uz => Assets.icons.flagUz,
        LangType.ru => Assets.icons.flagRu,
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

  String get title => switch (this) {
        OperatingSystemType.android => 'Android',
        OperatingSystemType.ios => 'Iphone',
      };

  IconData get icon => switch (this) {
        OperatingSystemType.android => Icons.android,
        OperatingSystemType.ios => Icons.apple,
      };

  static OperatingSystemType get current => Platform.isIOS ? OperatingSystemType.ios : OperatingSystemType.android;
}

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

enum StoryFileType {
  none,
  image,
  video;

  static StoryFileType getObj(String key) => switch (key) {
        'video' => StoryFileType.video,
        'image' => StoryFileType.image,
        _ => StoryFileType.none,
      };

  String get key => switch (this) {
        StoryFileType.video => 'video',
        StoryFileType.image => 'image',
        StoryFileType.none => '',
      };
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

  String get title => switch (this) {
        AutoLockTimeType.immediately => "Darhol",
        AutoLockTimeType.after5Seconds => "5 soniya",
        AutoLockTimeType.after10Seconds => "10 soniya",
        AutoLockTimeType.after30Seconds => "30 soniya",
        AutoLockTimeType.after1Minute => "1 minut",
        AutoLockTimeType.after5Minutes => "5 minut",
        AutoLockTimeType.after10Minutes => "10 minut",
        AutoLockTimeType.after30Minutes => "30 minut",
        AutoLockTimeType.after1Hour => "1 soat",
        AutoLockTimeType.disable => "O'chiq",
      };

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
