import 'package:easy_localization/easy_localization.dart';
import 'package:my_archive/core/utils/generated/assets.gen.dart';

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
