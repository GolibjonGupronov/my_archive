import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:pinput/pinput.dart';

class CustomPinPut extends Pinput {
  CustomPinPut({
    super.key,
    required BuildContext context,
    this.boxSize = 60,
    super.length = 6,
    super.onChanged,
    super.onCompleted,
    super.validator,
    super.obscureText,
    super.mainAxisAlignment,
    super.controller,
    super.readOnly = false,
    this.showBorder = true,
  }) : super(
          defaultPinTheme: _pinTheme(context, boxSize),
          focusedPinTheme: _pinTheme(context, boxSize).copyBorderWith(
            border: showBorder ? Border.all(color: AppColors.primary) : Border.all(color: Colors.transparent),
          ),
          errorPinTheme: _pinTheme(context, boxSize).copyBorderWith(border: Border.all(color: AppColors.red)),
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[^0-9]'))],
          keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
          hapticFeedbackType: HapticFeedbackType.lightImpact,
          cursor: showBorder
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(margin: EdgeInsets.only(bottom: 9.h), width: 22.w, height: 1.h, color: AppColors.primary),
                  ],
                )
              : SizedBox(),
        );

  final double boxSize;
  final bool showBorder;

  static PinTheme _pinTheme(BuildContext context, double boxSize) {
    return PinTheme(
      width: boxSize,
      height: boxSize,
      textStyle: AppTheme.textTheme.displayLarge?.copyWith(fontSize: 28.sp),
      decoration: BoxDecoration(
        color: context.isDarkModeEnable ? AppColors.whiteDark : AppColors.foregroundSecondary,
        borderRadius: BorderRadius.circular(16.r),
      ),
    );
  }
}
