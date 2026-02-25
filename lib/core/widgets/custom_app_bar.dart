import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/app_router.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/widgets/text_view.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(
    String titleText, {
    bool? canBack = true,
    super.backgroundColor,
    super.key,
    super.actions,
  }) : super(
          title: TextView(titleText),
          elevation: 0,
          centerTitle: true,
          leadingWidth: canBack == true ? 56.w : 0,
          leading: canBack == true
              ? InkWell(
                  onTap: () async {
                    router.pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
                    child: Center(
                      child: Icon(CupertinoIcons.chevron_back, size: 24.w, color: AppColors.gray),
                    ),
                  ),
                )
              : const SizedBox(),
        );
}
