import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';

class BottomNavItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActive;
  final IconData iconData;
  final String title;

  const BottomNavItem({super.key, required this.onTap, required this.isActive, required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: onTap,
      child: BoxContainer(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 30.w),
        color: isActive ? AppColors.primary.withValues(alpha: .12) : null,
        borderRadius: BorderRadius.circular(60.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: Icon(iconData, color: isActive ? AppColors.primary : AppColors.gray,size: 22.w,)),
            4.height,
            AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 100),
              style: AppTheme.textTheme.titleMedium!.copyWith(
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400, color: isActive ? AppColors.primary : AppColors.gray),
              child: Text(title, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
