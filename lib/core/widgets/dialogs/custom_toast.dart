import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_archive/core/core_exports.dart';

void showErrorToast(BuildContext context, String message, {int second = Constants.toastDuration, bool isDismissible = true}) {
  final fToast = FToast();
  fToast.removeCustomToast();
  fToast.init(context);

  Widget toast = Row(
    children: [
      const Icon(Icons.warning_rounded, color: AppColors.red),
      12.width,
      Expanded(child: TextView(message)),
    ],
  );

  _show(fToast: fToast, second: second, child: toast, isDismissible: isDismissible);
}

void showSuccessToast(BuildContext context, String message, {int second = Constants.toastDuration, bool isDismissible = true}) {
  final fToast = FToast();
  fToast.removeCustomToast();
  fToast.init(context);

  Widget toast = Row(
    children: [
      const Icon(CupertinoIcons.checkmark_alt_circle_fill, color: AppColors.green),
      12.width,
      Expanded(child: TextView(message)),
    ],
  );

  _show(fToast: fToast, second: second, child: toast, isDismissible: isDismissible);
}

void showInfoToast(BuildContext context, String message, {int second = Constants.toastDuration, bool isDismissible = true}) {
  final fToast = FToast();
  fToast.removeCustomToast();
  fToast.init(context);

  Widget toast = Row(
    children: [
      const Icon(CupertinoIcons.info_circle_fill, color: AppColors.orange),
      12.width,
      Expanded(child: TextView(message)),
    ],
  );

  _show(fToast: fToast, second: second, child: toast, isDismissible: isDismissible);
}

void _show({
  required FToast fToast,
  required Widget child,
  required int second,
  required bool isDismissible,
}) {
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
                  right: 16.w,
                  top: 16.h,
                ),
                child: child,
              ),
              12.height,
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: 0.0),
                duration: Duration(seconds: second),
                builder: (context, value, _) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor:
                    AppColors.primary.withValues(alpha: 0.3),
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
    positionedToastBuilder: (context, child, gravity){
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
