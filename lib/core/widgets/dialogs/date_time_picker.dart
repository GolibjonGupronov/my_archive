import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';

class DateTimePicker {
  static Future<void> calendarSingle(
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

  static Future<void> calendarRange(
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

  static Future<void> cupertinoTime(
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
          14.height,
          SizedBox(
            height: 180.h,
            child: CupertinoDatePicker(
              initialDateTime: dateTime,
              onDateTimeChanged: (time) {
                dateTime = time;
              },
              mode: CupertinoDatePickerMode.time,
              use24hFormat: true,
              showTimeSeparator: true,
            ),
          ),
          18.height,
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

  static Future<void> cupertinoDate(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? minimumDate,
    bool barrierDismissible = true,
    required Function(DateTime time) result,
  }) async {
    DateTime dateTime = initialDate ?? DateTime.now();
    await showCustomBottomSheetDialog(
      context: context,
      isDismissible: barrierDismissible,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          14.height,
          TextView("Kun tanlang", fontSize: 24.sp),
          14.height,
          SizedBox(
            height: 180.h,
            child: CupertinoDatePicker(
              initialDateTime: dateTime,
              onDateTimeChanged: (time) {
                dateTime = time;
              },
              mode: CupertinoDatePickerMode.date,
              dateOrder: DatePickerDateOrder.dmy,
            ),
          ),
          18.height,
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
}
