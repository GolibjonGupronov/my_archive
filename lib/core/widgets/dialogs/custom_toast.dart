import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_archive/core/core_exports.dart';

void showErrorToast(
  BuildContext context,
  String message, {
  int second = Constants.toastDuration,
  bool isDismissible = true,
  VoidCallback? action,
  String? actionTitle,
}) {
  _showToast(
    context,
    message,
    icon: Icons.warning_rounded,
    color: AppColors.red,
    second: second,
    isDismissible: isDismissible,
    action: action,
    actionTitle: actionTitle,
  );
}

void showSuccessToast(
  BuildContext context,
  String message, {
  int second = Constants.toastDuration,
  bool isDismissible = true,
  VoidCallback? action,
  String? actionTitle,
}) {
  _showToast(
    context,
    message,
    icon: CupertinoIcons.checkmark_alt_circle_fill,
    color: AppColors.green,
    second: second,
    isDismissible: isDismissible,
    action: action,
    actionTitle: actionTitle,
  );
}

void showInfoToast(
  BuildContext context,
  String message, {
  int second = Constants.toastDuration,
  bool isDismissible = true,
  VoidCallback? action,
  String? actionTitle,
}) {
  _showToast(
    context,
    message,
    icon: CupertinoIcons.info_circle_fill,
    color: AppColors.orange,
    second: second,
    isDismissible: isDismissible,
    action: action,
    actionTitle: actionTitle,
  );
}

void _showToast(
  final BuildContext context,
  final String message, {
  required IconData icon,
  required Color color,
  int second = Constants.toastDuration,
  bool isDismissible = true,
  final VoidCallback? action,
  final String? actionTitle,
}) {
  final fToast = FToast();
  fToast.removeCustomToast();
  fToast.init(context);

  final toastKey = UniqueKey();

  fToast.showToast(
    child: Dismissible(
      key: toastKey,
      confirmDismiss: (_) async => isDismissible,
      direction: DismissDirection.horizontal,
      onDismissed: (_) {
        fToast.removeCustomToast();
      },
      child: BoxContainer(
        withShadow: true,
        shadowColor: AppColors.primary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16.r),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 8.w,
                  top: 16.h,
                ),
                child: Row(
                  children: [
                    Icon(icon, color: color),
                    12.width,
                    Expanded(child: TextView(message)),
                    4.width,
                    if (action != null)
                      Bounce(
                        onTap: action,
                        child: BoxContainer(
                            padding: EdgeInsets.all(8.w),
                            borderRadius: BorderRadius.circular(8.r),
                            color: AppColors.primary,
                            child: TextView(actionTitle ?? "Batafsil", color: AppColors.white)),
                      )
                  ],
                ),
              ),
              12.height,
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: 0.0),
                duration: Duration(seconds: second),
                builder: (context, value, _) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ),
    toastDuration: Duration(seconds: second),
    positionedToastBuilder: (context, child, gravity) {
      final bottomInset = MediaQuery.of(context).viewInsets.bottom;

      return Positioned(
        left: 16.w,
        right: 16.w,
        bottom: bottomInset + 16.h,
        child: child,
      );
    },
  );
}
