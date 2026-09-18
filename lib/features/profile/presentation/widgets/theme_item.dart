import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/exports/ui_exports.dart';

class ThemeItem extends StatelessWidget {
  final AdaptiveThemeMode mode;
  final AssetGenImage image;
  final String title;
  final bool isSelected;
  final Function(AdaptiveThemeMode value) onTap;

  const ThemeItem(
      {super.key, required this.image, required this.title, required this.isSelected, required this.mode, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: () => onTap(mode),
      child: Column(
        children: [
          BoxContainer(
              border: Border.all(color: isSelected ? AppColors.primary : AppColors.lightGray, width: 2.w),
              borderRadius: BorderRadius.circular(12.r),
              child: ClipRRect(borderRadius: BorderRadius.circular(10.r), child: image.image(width: 100.w))),
          8.height,
          TextView(title, color: isSelected ? AppColors.primary : AppColors.gray),
          Icon(isSelected ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.circle,
              color: isSelected ? AppColors.primary : AppColors.gray),
          8.height
        ],
      ),
    );
  }
}
