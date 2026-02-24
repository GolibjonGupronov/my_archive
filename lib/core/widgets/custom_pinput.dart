import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:pinput/pinput.dart';

class CustomPinPut extends Pinput {
  CustomPinPut({
    super.key,
    double boxSize = 60,
    super.length = 6,
    super.onChanged,
    super.onCompleted,
    super.validator,
    super.obscureText,
    super.mainAxisAlignment,
    required super.controller,
  }) : super(
          defaultPinTheme: _pinTheme(boxSize),
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[^0-9]'))],
          keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
          hapticFeedbackType: HapticFeedbackType.lightImpact,
          cursor: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 9),
                width: 22,
                height: 1,
                color: AppColors.black,
              ),
            ],
          ),
          focusedPinTheme: _pinTheme(boxSize).copyWith(
            decoration: _pinTheme(boxSize).decoration!.copyWith(
                  border: Border.all(color: AppColors.primary),
                ),
          ),
          errorPinTheme: _pinTheme(boxSize).copyBorderWith(
            border: Border.all(color: AppColors.red),
          ),
        );

  static PinTheme _pinTheme(double boxSize) {
    return PinTheme(
      width: boxSize,
      height: boxSize,
      textStyle: const TextStyle(
        fontSize: 36,
        color: Colors.black,
        fontWeight: FontWeight.w800,
      ),
      decoration: BoxDecoration(
        color: AppColors.foregroundSecondary,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
