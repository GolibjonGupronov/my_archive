import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/app_router.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/constants/gradients.dart';
import 'package:my_archive/core/extensions/common.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/theme/app_theme.dart';
import 'package:my_archive/core/widgets/box_conatiner.dart';
import 'package:my_archive/core/widgets/button.dart';
import 'package:my_archive/core/widgets/text_view.dart';

Future<dynamic> showCustomDialog(
  final BuildContext context, {
  required final Widget child,
  final bool barrierDismissible = false,
}) async {
  return _generalDialog(
    context: context,
    title: "",
    barrierDismissible: barrierDismissible,
    child: _CustomDialog.customDialog(
      barrierDismissible: barrierDismissible,
      child: child,
    ),
  );
}

Future<dynamic> showConfirmDialog(
  final BuildContext context,
  final String title, {
  final String? subTitle,
  final Widget? icon,
  final VoidCallback? onConfirm,
  final VoidCallback? onCancel,
  final DialogButton? confirmButton,
  final DialogButton? cancelButton,
  final bool barrierDismissible = false,
  final MyDialogType type = MyDialogType.none,
}) async {
  return _generalDialog(
    context: context,
    title: title,
    barrierDismissible: barrierDismissible,
    child: _CustomDialog.confirmDialog(
      title: title,
      subTitle: subTitle,
      icon: icon,
      onConfirm: onConfirm,
      onCancel: onCancel,
      confirmButtonStyle: confirmButton ?? DialogButton.confirm(),
      cancelButtonStyle: cancelButton ?? DialogButton.cancel(),
      barrierDismissible: barrierDismissible,
      type: type,
      subTitleAlignment: TextAlign.center,
    ),
  );
}

Future<dynamic> showRejectDialog(
  final BuildContext context,
  final String title, {
  final String? subTitle,
  final Widget? icon,
  final VoidCallback? onConfirm,
  final VoidCallback? onCancel,
  final DialogButton? confirmButton,
  final DialogButton? cancelButton,
  final bool barrierDismissible = false,
  final MyDialogType type = MyDialogType.none,
}) async {
  return _generalDialog(
    context: context,
    title: title,
    barrierDismissible: barrierDismissible,
    child: _CustomDialog.confirmDialog(
      title: title,
      subTitle: subTitle,
      icon: icon,
      onConfirm: onConfirm,
      onCancel: onCancel,
      confirmButtonStyle: confirmButton ?? DialogButton.confirm(buttonColor: AppColors.lightGray, textColor: AppColors.black),
      cancelButtonStyle: cancelButton ?? DialogButton.cancel(buttonColor: AppColors.primary, textColor: AppColors.white),
      barrierDismissible: barrierDismissible,
      type: type,
      subTitleAlignment: TextAlign.center,
    ),
  );
}

Future<dynamic> showSuccessDialog(
  BuildContext context, {
  required String title,
  String? subTitle,
  VoidCallback? onConfirm,
  DialogButton? confirmButtonStyle,
  bool barrierDismissible = false,
}) async {
  return _generalDialog(
    context: context,
    title: title,
    barrierDismissible: barrierDismissible,
    child: _CustomDialog.infoDialog(
      title: title,
      subTitle: subTitle,
      onConfirm: onConfirm,
      confirmButtonStyle: confirmButtonStyle ?? DialogButton.confirm(text: "OK"),
      barrierDismissible: barrierDismissible,
      type: MyDialogType.success,
    ),
  );
}

Future<dynamic> showWarningDialog(
  BuildContext context, {
  required String title,
  String? subTitle,
  VoidCallback? onConfirm,
  DialogButton? confirmButtonStyle,
  bool barrierDismissible = false,
}) async {
  return _generalDialog(
    context: context,
    title: title,
    barrierDismissible: barrierDismissible,
    child: _CustomDialog.infoDialog(
      title: title,
      subTitle: subTitle,
      onConfirm: onConfirm,
      confirmButtonStyle: confirmButtonStyle ?? DialogButton.confirm(text: "OK"),
      barrierDismissible: barrierDismissible,
      type: MyDialogType.warning,
    ),
  );
}

Future<void> showErrorDialog(
  BuildContext context, {
  required String title,
  String? subTitle,
  VoidCallback? onConfirm,
  DialogButton? confirmButtonStyle,
  bool barrierDismissible = false,
}) async {
  return await _generalDialog(
    context: context,
    title: title,
    barrierDismissible: barrierDismissible,
    child: _CustomDialog.infoDialog(
      title: title,
      subTitle: subTitle,
      onConfirm: onConfirm,
      confirmButtonStyle: confirmButtonStyle ?? DialogButton.confirm(text: "OK"),
      barrierDismissible: barrierDismissible,
      type: MyDialogType.error,
    ),
  );
}

enum MyDialogType {
  none,
  success,
  error,
  warning;

  Widget? get icon => switch (this) {
        MyDialogType.success => _myIcon(CupertinoIcons.checkmark_alt, Gradients.greenGradient),
        MyDialogType.error => _myIcon(CupertinoIcons.clear, Gradients.redGradient),
        MyDialogType.warning => _myIcon(CupertinoIcons.exclamationmark, Gradients.orangeGradient),
        MyDialogType.none => null,
      };

  Widget _myIcon(IconData icon, Gradient gradient) {
    return BoxContainer(size: 60.w, shape: BoxShape.circle, gradient: gradient, child: Icon(icon, color: AppColors.white));
  }
}

class DialogButton {
  final String text;
  final Color textColor;
  final Color buttonColor;

  const DialogButton._({
    required this.text,
    required this.textColor,
    required this.buttonColor,
  });

  factory DialogButton.confirm({
    String? text,
    Color? textColor,
    Color? buttonColor,
  }) =>
      DialogButton._(
        text: text ?? tr('yes'),
        textColor: textColor ?? Colors.white,
        buttonColor: buttonColor ?? AppColors.primary,
      );

  factory DialogButton.cancel({
    String? text,
    Color? textColor,
    Color? buttonColor,
  }) =>
      DialogButton._(
        text: text ?? tr('no'),
        textColor: textColor ?? Colors.black,
        buttonColor: buttonColor ?? AppColors.lightGray,
      );
}

Future<void> _generalDialog({
  required BuildContext context,
  required String title,
  required bool barrierDismissible,
  required _CustomDialog child,
}) {
  return showDialog(
    barrierLabel: title,
    useSafeArea: false,
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (context) => child,
  );
}

class _CustomDialog extends StatelessWidget {
  final bool barrierDismissible;
  final TextAlign subTitleAlignment;
  final Widget? icon;
  final String title;
  final String? subTitle;
  final bool visibleCancel;
  final DialogButton? confirmButtonStyle;
  final DialogButton? cancelButtonStyle;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final MyDialogType type;
  final bool withBlur;
  final Widget? child;

  const _CustomDialog._({
    required this.barrierDismissible,
    this.subTitleAlignment = TextAlign.center,
    this.icon,
    required this.title,
    this.subTitle,
    this.visibleCancel = true,
    this.confirmButtonStyle,
    this.cancelButtonStyle,
    this.onConfirm,
    this.onCancel,
    this.withBlur = false,
    this.type = MyDialogType.none,
    this.child,
  });

  factory _CustomDialog.customDialog({
    required Widget child,
    required bool barrierDismissible,
  }) {
    return _CustomDialog._(
      title: "",
      barrierDismissible: barrierDismissible,
      subTitle: "",
      child: child,
    );
  }

  factory _CustomDialog.confirmDialog({
    required String title,
    final String? subTitle,
    required bool barrierDismissible,
    final TextAlign subTitleAlignment = TextAlign.center,
    final Widget? icon,
    final VoidCallback? onConfirm,
    final VoidCallback? onCancel,
    final DialogButton? confirmButtonStyle,
    final DialogButton? cancelButtonStyle,
    required MyDialogType type,
  }) {
    return _CustomDialog._(
      title: title,
      barrierDismissible: barrierDismissible,
      subTitle: subTitle,
      subTitleAlignment: subTitleAlignment,
      icon: icon,
      onConfirm: onConfirm,
      onCancel: onCancel,
      confirmButtonStyle: confirmButtonStyle,
      cancelButtonStyle: cancelButtonStyle,
      type: type,
    );
  }

  factory _CustomDialog.infoDialog({
    required String title,
    required bool barrierDismissible,
    final String? subTitle,
    final TextAlign subTitleAlignment = TextAlign.center,
    final VoidCallback? onConfirm,
    final DialogButton? confirmButtonStyle,
    required MyDialogType type,
  }) {
    return _CustomDialog._(
      title: title,
      barrierDismissible: barrierDismissible,
      subTitle: subTitle,
      subTitleAlignment: subTitleAlignment,
      onConfirm: onConfirm,
      visibleCancel: false,
      confirmButtonStyle: confirmButtonStyle,
      type: type,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ic = icon ?? type.icon;

    final confirmButton = confirmButtonStyle ?? DialogButton.confirm();

    final cancelButton = cancelButtonStyle ?? DialogButton.cancel();
    return PopScope(
      canPop: barrierDismissible,
      child: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          if (withBlur)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  if (barrierDismissible) {
                    router.pop();
                  }
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: Container(color: Colors.black.withValues(alpha: 0.1)),
                ),
              ),
            ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 26.w,
                  right: 26.w,
                  bottom: context.keyboardBottom + context.safeBottom(16.h),
                  top: context.keyboardTop + context.safeTop(16.h)),
              child: BoxContainer(
                padding: EdgeInsets.all(16.w),
                borderRadius: BorderRadius.circular(16.r),
                child: Material(
                  color: Colors.transparent,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    primary: false,
                    children: child != null
                        ? [child!]
                        : [
                            if (ic != null) Center(child: ic),
                            if (ic != null) 12.height,
                            TextView(title, fontSize: 20.sp, textAlign: TextAlign.center),
                            if (subTitle != null) 8.height,
                            if (subTitle != null)
                              TextView(subTitle!,
                                  textAlign: subTitleAlignment,
                                  style: AppTheme.textTheme.titleMedium?.copyWith(color: AppColors.gray)),
                            24.height,
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    confirmButton.text,
                                        () {
                                      router.pop();
                                      onConfirm?.call();
                                    },
                                    fillColor: confirmButton.buttonColor,
                                    textColor: confirmButton.textColor,
                                  ),
                                ),
                                if (visibleCancel) ...[
                                  10.width,
                                  Expanded(
                                    child: CustomButton(
                                      cancelButton.text,
                                      () {
                                        router.pop();
                                        onCancel?.call();
                                      },
                                      fillColor: cancelButton.buttonColor,
                                      textColor: cancelButton.textColor,
                                    ),
                                  ),
                                ],

                              ],
                            ),
                          ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
