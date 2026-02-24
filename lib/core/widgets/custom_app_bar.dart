import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/app_router.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/widgets/custom_text_view.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(
    String titleText, {
    bool? canBack = true,
    super.backgroundColor,
    super.key,
    super.actions,
  }) : super(
          title: CustomTextView(titleText),
          elevation: 0,
          centerTitle: true,
          leadingWidth: canBack == true ? 56 : 0,
          leading: canBack == true
              ? InkWell(
                  onTap: () async {
                    router.pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    child: Center(
                      child: Icon(CupertinoIcons.chevron_back, size: 24.w, color: AppColors.gray),
                    ),
                  ),
                )
              : const SizedBox(),
        );
}
