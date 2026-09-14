import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_archive/core/exports/core_exports.dart';
import 'package:my_archive/features/profile/presentation/widgets/theme_item.dart';

class ThemeWidget extends StatefulWidget {
  const ThemeWidget({super.key});

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  late AdaptiveThemeMode mode;
  bool initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!initialized) {
      mode = AdaptiveTheme.of(context).mode;
      initialized = true;
    }
  }

  void _onThemeSelected(AdaptiveThemeMode value) {
    setState(() => mode = value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextView("Mavzu tanlang"),
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ThemeItem(
                mode: AdaptiveThemeMode.light,
                image: Assets.images.light,
                title: tr('theme_light'),
                isSelected: mode == AdaptiveThemeMode.light,
                onTap: _onThemeSelected,
              ),
              ThemeItem(
                mode: AdaptiveThemeMode.dark,
                image: Assets.images.dark,
                title: tr('theme_dark'),
                isSelected: mode == AdaptiveThemeMode.dark,
                onTap: _onThemeSelected,
              ),
            ],
          ),
          10.height,
          CustomButton(tr('save'), () {
            AdaptiveTheme.of(context).setThemeMode(mode);
            router.pop();
          }),
          16.height,
        ],
      ),
    );
  }
}
