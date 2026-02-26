import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/theme/app_theme.dart';
import 'package:my_archive/core/widgets/box_conatiner.dart';
import 'package:my_archive/core/widgets/button.dart';
import 'package:my_archive/core/widgets/text_view.dart';

class CustomCalendarView extends StatefulWidget {
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final bool barrierDismissible;
  final Function(DateTime)? onSingleApply;
  final Function(DateTime, DateTime)? onRangeApply;
  final CalendarDatePicker2Type _calendarType;

  const CustomCalendarView._({
    this.minimumDate,
    this.maximumDate,
    this.initialStartDate,
    this.initialEndDate,
    this.barrierDismissible = true,
    this.onSingleApply,
    this.onRangeApply,
    required CalendarDatePicker2Type calendarType,
  }) : _calendarType = calendarType;

  factory CustomCalendarView.single({
    DateTime? initialStart,
    DateTime? minimumDate,
    DateTime? maximumDate,
    bool barrierDismissible = true,
    required Function(DateTime) onApply,
  }) {
    return CustomCalendarView._(
      initialStartDate: initialStart,
      minimumDate: minimumDate,
      maximumDate: maximumDate,
      barrierDismissible: barrierDismissible,
      onSingleApply: onApply,
      calendarType: CalendarDatePicker2Type.single,
    );
  }

  factory CustomCalendarView.range({
    DateTime? initialStart,
    DateTime? initialEnd,
    DateTime? minimumDate,
    DateTime? maximumDate,
    bool barrierDismissible = true,
    required Function(DateTime, DateTime) onApply,
  }) {
    return CustomCalendarView._(
      initialStartDate: initialStart,
      initialEndDate: initialEnd,
      minimumDate: minimumDate,
      maximumDate: maximumDate,
      barrierDismissible: barrierDismissible,
      onRangeApply: onApply,
      calendarType: CalendarDatePicker2Type.range,
    );
  }

  @override
  State<CustomCalendarView> createState() => _CustomCalendarViewState();
}

class _CustomCalendarViewState extends State<CustomCalendarView> {
  late DateTime? startDate;
  late DateTime? endDate;

  @override
  void initState() {
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: widget._calendarType,
      closeDialogOnCancelTapped: false,
      dayTextStyle: AppTheme.textTheme.titleLarge,
      selectedDayHighlightColor: AppColors.primary,
      firstDayOfWeek: 1,
      firstDate: widget.minimumDate,
      lastDate: widget.maximumDate,
      yearTextStyle: AppTheme.textTheme.titleLarge,
      monthTextStyle: AppTheme.textTheme.titleLarge,
      weekdayLabelTextStyle: AppTheme.textTheme.titleLarge,
      controlsTextStyle: AppTheme.textTheme.titleLarge,
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      disabledDayTextStyle: AppTheme.textTheme.titleLarge!.copyWith(color: AppColors.gray),
      disabledMonthTextStyle: AppTheme.textTheme.titleLarge!.copyWith(color: AppColors.gray),
      disabledYearTextStyle: AppTheme.textTheme.titleLarge!.copyWith(color: AppColors.gray),
      selectedDayTextStyle: AppTheme.textTheme.titleLarge!.copyWith(color: AppColors.white),
      selectedYearTextStyle: AppTheme.textTheme.titleLarge!.copyWith(color: AppColors.white),
      selectedMonthTextStyle: AppTheme.textTheme.titleLarge!.copyWith(color: AppColors.white),
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;
        if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
          textStyle = TextStyle(color: Colors.red[500], fontWeight: FontWeight.w600);
        }
        // if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
        //   textStyle = TextStyle(color: Colors.red[400], fontWeight: FontWeight.w700, decoration: TextDecoration.underline);
        // }
        return textStyle;
      },
      dayBuilder: ({
        required date,
        textStyle,
        decoration,
        isSelected,
        isDisabled,
        isToday,
      }) {
        Widget? dayWidget;
        if (date.day % 3 == 0 && date.day % 9 != 0) {
          dayWidget = Container(
            decoration: decoration,
            child: Center(
              child: Text(MaterialLocalizations.of(context).formatDecimal(date.day), style: textStyle),
            ),
          );
        }
        return dayWidget;
      },
      yearBuilder: ({required year, decoration, isCurrentYear, isDisabled, isSelected, textStyle}) {
        return Center(
          child: Container(
            decoration: decoration,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(year.toString(), style: textStyle),
                if (isCurrentYear == true)
                  Container(
                      margin: EdgeInsets.only(left: 6.h),
                      width: 8.w,
                      height: 8.w,
                      decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle)),
              ],
            ),
          ),
        );
      },
    );
    return Center(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (widget.barrierDismissible) {
              context.pop();
            }
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: BoxContainer(
                  borderRadius: BorderRadius.all(Radius.circular(24.r)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (widget._calendarType == CalendarDatePicker2Type.range)
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  CustomTextView("Dan", textAlign: TextAlign.left),
                                  4.height,
                                  CustomTextView(
                                    startDate != null ? DateFormat('dd/MM/yy').format(startDate!) : '--/--/-- '
                                  ),
                                ],
                              ),
                            ),
                            Container(height: 70.h, width: 1.w, color: Theme.of(context).dividerColor),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  CustomTextView("Gacha"),
                                  4.height,
                                  CustomTextView(endDate != null ? DateFormat('dd/MM/yy').format(endDate!) : '--/--/-- '),
                                ],
                              ),
                            )
                          ],
                        ),
                      if (widget._calendarType == CalendarDatePicker2Type.range) Divider(height: 1.h),
                      Container(
                        color: Colors.transparent,
                        child: CalendarDatePicker2(
                          value: widget._calendarType == CalendarDatePicker2Type.single ? [startDate] : [startDate, endDate],
                          config: config,
                          onValueChanged: (values) {
                            setState(() {
                              startDate = values.firstOrNull ?? widget.initialStartDate;
                              endDate = values.length > 1 ? values.lastOrNull : null;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                        child: CustomButton(tr('save'), () {
                          if (widget._calendarType == CalendarDatePicker2Type.single) {
                            if (startDate != null) {
                              widget.onSingleApply?.call(startDate!);
                            }
                          } else {
                            if (startDate != null && endDate != null) {
                              widget.onRangeApply?.call(startDate!, endDate!);
                            } else if (startDate != null && endDate == null) {
                              widget.onRangeApply?.call(startDate!, startDate!);
                            }
                          }
                          context.pop();
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
