import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final IconData prefixIconData;
  final Widget? prefixIconWidget;
  final Widget? suffixWidget;
  final VoidCallback? onTap;

  const ProfileItem(
      {super.key, required this.title, required this.prefixIconData, this.onTap, this.suffixWidget, this.prefixIconWidget});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      scale: onTap != null,
      onTap: onTap,
      child: BoxContainer(
        color: context.isDarkModeEnable ? AppColors.whiteDark : AppColors.white,
        withShadow: true,
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        borderRadius: BorderRadius.circular(50.r),
        child: SizedBox(
            height: 64.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BoxContainer(
                  padding: EdgeInsets.all(6.w),
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  child: prefixIconWidget ?? Icon(prefixIconData, size: 22.w, color: AppColors.white),
                ),
                12.width,
                Expanded(child: TextView(title, maxLines: 1)),
                4.width,
                suffixWidget ?? Icon(CupertinoIcons.chevron_forward),
              ],
            )),
      ),
    );
  }
}
