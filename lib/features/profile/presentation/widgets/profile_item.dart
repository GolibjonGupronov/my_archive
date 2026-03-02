import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final Widget? rightWidget;
  final VoidCallback? onTap;

  const ProfileItem({super.key, this.rightWidget, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      scale: onTap != null,
      onTap: onTap,
      child: BoxContainer(
        color: context.isDarkModeEnable ? AppColors.whiteDark : AppColors.white,
        withShadow: true,
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        borderRadius: BorderRadius.circular(16.r),
        child: SizedBox(
            height: 64.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: TextView(title, maxLines: 1)),
                rightWidget ?? Icon(CupertinoIcons.chevron_forward),
              ],
            )),
      ),
    );
  }
}
