import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/constants/constants.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/extensions/string.dart';
import 'package:my_archive/core/theme/app_theme.dart';
import 'package:my_archive/core/utils/generated/assets.gen.dart';
import 'package:my_archive/core/utils/thousands_formatter.dart';
import 'package:my_archive/core/widgets/text_view.dart';

enum _EnumTextFieldType { text, phone, password, thousandFormat }

class CustomTextField extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final String? hint;
  final String comment;
  final bool required;
  final bool enabled;
  final TextInputType? inputType;
  final Function(String v)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int? minLines;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final int? maxLength;
  final String Function(String v)? validate;
  final bool autofocus;
  final _EnumTextFieldType _textFieldType;

  const CustomTextField._(
    this.title, {
    this.controller,
    this.required = false,
    this.onChanged,
    this.hint,
    this.comment = "",
    this.inputType,
    this.inputFormatters,
    this.enabled = true,
    this.minLines,
    this.maxLines,
    this.textInputAction,
    this.obscureText = false,
    this.maxLength,
    this.validate,
    this.autofocus = false,
    required _EnumTextFieldType textFieldType,
  }) : _textFieldType = textFieldType;

  factory CustomTextField(
    final String title, {
    final TextEditingController? controller,
    final String? hint,
    final String comment = "",
    final bool required = false,
    final bool enabled = true,
    final TextInputType? inputType,
    final Function(String v)? onChanged,
    final List<TextInputFormatter>? inputFormatters,
    final int? minLines,
    final int? maxLines,
    final TextInputAction? textInputAction,
    final bool obscureText = false,
    final int? maxLength,
    final bool autofocus = false,
    final String Function(String v)? validate,
  }) {
    return CustomTextField._(
      title,
      controller: controller,
      hint: hint,
      comment: comment,
      required: required,
      enabled: enabled,
      inputType: inputType,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      minLines: minLines,
      maxLines: maxLines,
      textInputAction: textInputAction,
      obscureText: obscureText,
      maxLength: maxLength,
      validate: validate,
      autofocus: autofocus,
      textFieldType: _EnumTextFieldType.text,
    );
  }

  factory CustomTextField.phone(
    final String title, {
    final TextEditingController? controller,
    final String? hint,
    final String comment = "",
    final bool required = false,
    final bool enabled = true,
    final List<TextInputFormatter>? inputFormatters,
    final Function(String v)? onChanged,
    final String Function(String v)? validate,
    final bool autofocus = false,
  }) {
    return CustomTextField._(
      title,
      controller: controller,
      hint: hint,
      comment: comment,
      required: required,
      enabled: enabled,
      onChanged: onChanged,
      validate: validate,
      inputFormatters: inputFormatters,
      inputType: TextInputType.phone,
      autofocus: autofocus,
      textFieldType: _EnumTextFieldType.phone,
    );
  }

  factory CustomTextField.password(
    final String title, {
    final TextEditingController? controller,
    final String? hint,
    final String comment = "",
    final bool required = false,
    final bool enabled = true,
    final bool obscureText = true,
    final TextInputType? inputType,
    final Function(String v)? onChanged,
    final List<TextInputFormatter>? inputFormatters,
    final int? maxLength,
    final bool autofocus = false,
    final String Function(String v)? validate,
  }) {
    String defaultValidator(String v) {
      return v.removeSpaces.length < Constants.passwordLength ? tr('min_chars_required'.plural(Constants.passwordLength)) : "";
    }

    return CustomTextField._(
      title,
      controller: controller,
      hint: hint ?? tr('enter_password'),
      comment: comment,
      required: required,
      enabled: enabled,
      obscureText: obscureText,
      onChanged: onChanged,
      validate: validate ?? defaultValidator,
      maxLength: maxLength,
      inputFormatters: inputFormatters ?? [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
      inputType: inputType,
      autofocus: autofocus,
      textFieldType: _EnumTextFieldType.password,
    );
  }

  factory CustomTextField.comment(
    final String title, {
    final TextEditingController? controller,
    final String? hint,
    final String comment = "",
    final bool required = false,
    final bool enabled = true,
    final TextInputType? inputType,
    final Function(String v)? onChanged,
    final List<TextInputFormatter>? inputFormatters,
    final int? maxLength,
    final int maxLines = 4,
    final bool autofocus = false,
    final String Function(String v)? validate,
  }) {
    return CustomTextField._(
      title,
      controller: controller,
      hint: hint ?? tr('enter_comment'),
      comment: comment,
      required: required,
      enabled: enabled,
      onChanged: onChanged,
      validate: validate,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      inputType: inputType,
      autofocus: autofocus,
      maxLines: maxLines,
      textFieldType: _EnumTextFieldType.text,
    );
  }

  factory CustomTextField.thousandFormat(
    final String title, {
    final TextEditingController? controller,
    final String? hint,
    final String comment = "",
    final bool required = false,
    final bool enabled = true,
    final Function(String v)? onChanged,
    final int? maxLength,
    final bool autofocus = false,
    final String Function(String v)? validate,
  }) {
    return CustomTextField._(
      title,
      controller: controller,
      hint: hint,
      comment: comment,
      required: required,
      enabled: enabled,
      onChanged: onChanged,
      maxLength: maxLength,
      validate: validate,
      autofocus: autofocus,
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[^0-9,. ]')), ThousandsSeparatorInputFormatter()],
      inputType: const TextInputType.numberWithOptions(decimal: true, signed: false),
      textFieldType: _EnumTextFieldType.thousandFormat,
    );
  }

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode focusNode = FocusNode();
  Timer? bouncedTimer;
  String errorMessage = "";
  bool hiddenPassword = true;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() => setState(() {});

  void onChanged(String v) {
    bouncedTimer?.cancel();
    bouncedTimer = Timer(const Duration(milliseconds: 500), () {
      String error = "";
      if (widget.required && v.isEmpty) {
        error = tr('field_required');
      } else if (widget.validate != null) {
        error = widget.validate!(v);
      }
      if (errorMessage != error) {
        setState(() {
          errorMessage = error;
        });
      }
    });

    if (widget.onChanged != null) widget.onChanged!(v);
  }

  @override
  void dispose() {
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
    bouncedTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.enabled ? 1 : 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.title.isNotEmpty)
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.title,
                    style: AppTheme.textTheme.headlineMedium?.copyWith(color: AppColors.red),
                  ),
                  if (widget.required)
                    TextSpan(
                      text: " *",
                      style: AppTheme.textTheme.headlineMedium?.copyWith(color: AppColors.red),
                    ),
                ],
              ),
            ),
          if (widget.title.isNotEmpty) 10.height,
          Container(
            decoration: BoxDecoration(
              color: AppColors.foregroundSecondary,
              border: Border.all(color: errorMessage.isNotEmpty ? AppColors.red : AppColors.hint, width: 0.8),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: TextField(
                              textInputAction: widget.textInputAction,
                              enabled: widget.enabled,
                              obscureText: widget.obscureText ? hiddenPassword : false,
                              decoration: InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: widget.hint ?? widget.title,
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: AppColors.hint,
                                ),
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 18.h),
                                isDense: true,
                                suffixText: null,
                              ),
                              autofocus: widget.autofocus,
                              inputFormatters: widget.inputFormatters,
                              style: AppTheme.textTheme.headlineSmall,
                              focusNode: focusNode,
                              controller: widget.controller,
                              keyboardType: widget.inputType,
                              minLines: widget.obscureText ? null : widget.minLines,
                              maxLines: widget.obscureText ? 1 : (widget.maxLines ?? 1),
                              onChanged: (v) {
                                onChanged(v);
                              },
                              maxLength: widget.maxLength,
                            ),
                          ),
                        ),
                        if (widget.obscureText)
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  hiddenPassword = !hiddenPassword;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 16.w),
                                child: (hiddenPassword ? Assets.icons.eyeOpen : Assets.icons.eyeHide).svg(
                                  width: 24.w,
                                  color: hiddenPassword ? AppColors.primary : AppColors.gray.withValues(alpha: 0.3),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: errorMessage.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Row(
                      children: [
                        Icon(Icons.clear_rounded, color: AppColors.red, size: 18.w),
                        4.width,
                        Expanded(child: TextView(errorMessage)),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          if (widget.comment.isNotEmpty)
            Container(padding: EdgeInsets.only(top: 4.h), child: TextView(widget.comment)),
        ],
      ),
    );
  }
}
