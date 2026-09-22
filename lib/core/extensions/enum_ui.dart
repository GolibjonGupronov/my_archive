import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_archive/core/enums/common.dart';
import 'package:my_archive/core/utils/generated/assets.gen.dart';

extension GenderUi on Gender {
  String get title => switch (this) {
        Gender.male => tr('male'),
        Gender.female => tr('female'),
      };

  SvgGenImage get iconSvg => switch (this) {
        Gender.male => Assets.icons.male,
        Gender.female => Assets.icons.female,
      };
}

extension LangTypeUi on LangType {
  Locale get locale => switch (this) {
        LangType.uz => Locale('uz'),
        LangType.ru => Locale('ru'),
      };

  String get title => switch (this) {
        LangType.uz => "O‘zbek",
        LangType.ru => "Русский",
      };

  SvgGenImage get iconSvg => switch (this) {
        LangType.uz => Assets.icons.flagUz,
        LangType.ru => Assets.icons.flagRu,
      };
}

extension OperatingSystemTypeUi on OperatingSystemType {
  String get title => switch (this) {
        OperatingSystemType.android => 'Android',
        OperatingSystemType.ios => 'Iphone',
      };

  IconData get icon => switch (this) {
        OperatingSystemType.android => Icons.android,
        OperatingSystemType.ios => Icons.apple,
      };
}

extension AutoLockTimeTypeUi on AutoLockTimeType {
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
}

extension FolderTypeUi on FolderType {
  String get title => switch (this) {
        FolderType.video => "Videolar",
        FolderType.audio => "Musiqalar",
        FolderType.image => "Rasmlar",
        FolderType.file => "Fayllar",
      };
}
