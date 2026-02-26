import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/extensions/common.dart';
import 'package:my_archive/core/theme/app_theme.dart';
import 'package:pinput/pinput.dart';

class CustomPinPut extends Pinput {
  CustomPinPut({
    super.key,
    final double boxSize = 60,
    super.length = 6,
    super.onChanged,
    super.onCompleted,
    super.validator,
    super.obscureText,
    super.mainAxisAlignment,
    super.controller,
    required BuildContext context,
  }) : super(
          defaultPinTheme: _pinTheme(context, boxSize),
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[^0-9]'))],
          keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
          hapticFeedbackType: HapticFeedbackType.lightImpact,
          cursor: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(margin: EdgeInsets.only(bottom: 9.h), width: 22.w, height: 1.h, color: AppColors.primary),
            ],
          ),
          focusedPinTheme: _pinTheme(context, boxSize).copyWith(
            decoration: _pinTheme(context, boxSize).decoration!.copyWith(
                  border: Border.all(color: AppColors.primary),
                ),
          ),
          errorPinTheme: _pinTheme(context, boxSize).copyBorderWith(
            border: Border.all(color: AppColors.red),
          ),
        );

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
