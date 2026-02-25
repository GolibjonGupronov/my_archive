import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/widgets/box_conatiner.dart';
import 'package:my_archive/core/widgets/text_view.dart';

void showErrorToast(BuildContext context, String message) {
  final fToast = FToast();
  fToast.removeCustomToast();
  fToast.init(context);

  Widget toast = BoxContainer(
    padding: EdgeInsets.all(16.w),
    withShadow: true,
    color: AppColors.red,
    borderRadius: BorderRadius.circular(16.r),
    child: Row(
      children: [
        const Icon(Icons.warning_rounded, color: AppColors.white),
        12.width,
        Expanded(child: TextView(message, color: AppColors.white)),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 3),
  );
}

void showSuccessToast(BuildContext context, String message) {
  final fToast = FToast();
  fToast.removeCustomToast();
  fToast.init(context);

  Widget toast = BoxContainer(
    padding: EdgeInsets.all(16.w),
    withShadow: true,
    borderRadius: BorderRadius.circular(16.r),
    child: Row(
      children: [
        const Icon(CupertinoIcons.checkmark_alt_circle_fill, color: AppColors.green),
        12.width,
        Expanded(child: TextView(message)),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 3),
  );
}
