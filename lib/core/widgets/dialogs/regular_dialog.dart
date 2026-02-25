import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/extensions/common.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/widgets/custom_button.dart';
import 'package:my_archive/core/widgets/custom_calendar_view.dart';
import 'package:my_archive/core/widgets/text_view.dart';

Future<void> showFlexibleBottomSheetDialog({
  required BuildContext context,
  required Widget child,
  bool isDismissible = true,
}) {
  return showFlexibleBottomSheet(
      minHeight: 0,
      initHeight: .5,
      maxHeight: .9,
      context: context,
      bottomSheetBorderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      builder: (context, scrollController, offset) => PopScope(
            canPop: isDismissible,
            child: ListView(
              controller: scrollController,
              primary: false,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              children: [
                4.height,
                Center(
                  child: Container(
                    width: 36.w,
                    height: 4.h,
                    margin: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.r), color: AppColors.gray),
                  ),
                ),
                2.height,
                child
              ],
            ),
          ),
      anchors: [0, 0.5, .9],
      isSafeArea: true,
      useRootScaffold: false,
      isDismissible: isDismissible);
}

Future<void> showCustomBottomSheetDialog({
  required BuildContext context,
  required Widget child,
  bool isDismissible = true,
}) {
  return showCustomModalBottomSheet(
    context: context,
    isDismissible: isDismissible,
    builder: (context) => PopScope(
      canPop: isDismissible,
      child: child,
    ),
    containerWidget: (context, animation, child) => Material(
      color: AppColors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          4.height,
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              margin: EdgeInsets.all(8.w),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.r), color: AppColors.gray),
            ),
          ),
          2.height,
          Container(
            constraints: BoxConstraints(maxHeight: context.screenHeight * .8),
            child: ListView(
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              primary: false,
              shrinkWrap: true,
              children: [child],
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> showCustomSingleDatePicker(
  BuildContext context, {
  DateTime? initialDate,
  DateTime? minimumDate,
  bool barrierDismissible = true,
  required Function(DateTime time) result,
}) async {
  return showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (context) => CustomCalendarView.single(
      initialStart: initialDate ?? DateTime.now(),
      minimumDate: minimumDate,
      onApply: (dateTime) {
        result(dateTime);
      },
    ),
  );
}

Future<void> showCustomRangeDatePicker(
  BuildContext context, {
  DateTime? initialStart,
  DateTime? initialEnd,
  DateTime? minimumDate,
  bool barrierDismissible = true,
  required Function(DateTime fromTime, DateTime toTime) result,
}) async {
  return showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (context) => CustomCalendarView.range(
      initialStart: initialStart,
      initialEnd: initialEnd,
      minimumDate: minimumDate,
      onApply: (fromTime, toTime) {
        result(fromTime, toTime);
      },
    ),
  );
}

Future<void> showCustomTimePicker(
  BuildContext context, {
  DateTime? initialTime,
  DateTime? minimumDate,
  bool barrierDismissible = true,
  required Function(DateTime time) result,
}) async {
  DateTime dateTime = initialTime ?? DateTime.now();
  await showCustomBottomSheetDialog(
    context: context,
    isDismissible: barrierDismissible,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        14.height,
        TextView(tr('choose_time'), fontSize: 24.sp),
        26.height,
        SizedBox(
          height: 180.h,
          child: CupertinoDatePicker(
            initialDateTime: dateTime,
            onDateTimeChanged: (time) {
              dateTime = time;
            },
            mode: CupertinoDatePickerMode.time,
            use24hFormat: true,
          ),
        ),
        30.height,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomButton(
            tr('save'),
            () {
              result(dateTime);
              Navigator.pop(context);
            },
          ),
        ),
        16.height,
      ],
    ),
  );
}
