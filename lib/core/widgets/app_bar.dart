import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(
    String titleText, {
    bool? showBackButton,
    super.backgroundColor,
    super.key,
    super.actions,
  }) : super(
          title: TextView(titleText, textAlign: TextAlign.center),
          elevation: 0,
          centerTitle: true,
          leadingWidth: _resolveCanBack(showBackButton) ? 56.w : 0,
          leading: _resolveCanBack(showBackButton)
              ? Bounce(
                  onTap: () async {
                    Navigator.of(globalNavigatorKey.currentContext!).maybePop();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
                    child: Center(
                      child: Icon(CupertinoIcons.chevron_back, size: 24.w),
                    ),
                  ),
                )
              : const SizedBox(),
        );

  static bool _resolveCanBack(bool? canBack) {
    if (canBack != null) return canBack;
    return router.canPop();
  }
}
