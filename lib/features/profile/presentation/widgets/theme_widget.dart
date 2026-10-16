import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/app_router.dart';
import 'package:my_archive/core/exports/ui_exports.dart';
import 'package:my_archive/core/extensions/enum_ui.dart';

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
            children: MyThemeMode.values.map((e) {
              final isSelected = mode == e.mode;
              return Bounce(
                onTap: () {
                  _onThemeSelected(e.mode);
                },
                child: Column(
                  children: [
                    BoxContainer(
                        border: Border.all(color: isSelected ? AppColors.primary : AppColors.lightGray, width: 2.w),
                        borderRadius: BorderRadius.circular(12.r),
                        child: ClipRRect(borderRadius: BorderRadius.circular(10.r), child: e.image.image(width: 100.w))),
                    8.height,
                    TextView(e.title, color: isSelected ? AppColors.primary : AppColors.gray),
                    Icon(isSelected ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.circle,
                        color: isSelected ? AppColors.primary : AppColors.gray),
                    8.height
                  ],
                ),
              );
            }).toList(),
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
