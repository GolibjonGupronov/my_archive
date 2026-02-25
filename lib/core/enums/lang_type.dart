import 'package:flutter/material.dart';
import 'package:my_archive/core/utils/generated/assets.gen.dart';

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
        LangType.uz => "O'zbekcha",
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
