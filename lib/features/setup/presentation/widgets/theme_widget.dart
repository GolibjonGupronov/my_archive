import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/setup/presentation/widgets/theme_icon_title.dart';

class ThemeWidget extends StatefulWidget {
  final Function(AdaptiveThemeMode theme) onTap;
  final AdaptiveThemeMode initMode;

  const ThemeWidget({super.key, required this.onTap, required this.initMode});

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  late AdaptiveThemeMode _curMode;

  @override
  void initState() {
    super.initState();
    _curMode = widget.initMode;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.all(30.w),
        child: BoxContainer(
          color: context.isDarkModeEnable ? AppColors.whiteDark : AppColors.white,
          padding: EdgeInsets.all(20.w),
          borderRadius: BorderRadius.circular(20.r),
          shadows: [
            BoxShadow(color: AppColors.shadow.withValues(alpha: 0.2), spreadRadius: 1, blurRadius: 20, offset: const Offset(1, 1))
          ],
          child: Column(
            children: [
              TextView("Mavzu tanlang"),
              16.height,
              ...AdaptiveThemeMode.values.map((item) {
                if (item == AdaptiveThemeMode.system) return const SizedBox();
                return Padding(
                  padding: EdgeInsets.only(bottom: 14.h),
                  child: Bounce(
                    onTap: () {
                      if (_curMode == item) return;
                      setState(() {
                        _curMode = item;
                        widget.onTap(item);
                      });
                    },
                    child: BoxContainer(
                      color: context.isDarkModeEnable ? AppColors.scaffoldDarkBackground : AppColors.foregroundSecondary,
                      borderRadius: BorderRadius.circular(40.r),
                      padding: EdgeInsets.all(20.w),
                      child: ThemeIconTitle(themeMode: item, currentMode: _curMode),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
