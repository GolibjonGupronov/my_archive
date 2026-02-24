import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/constants/constants.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/extensions/string.dart';

enum _EnumTextFieldType { text, phone, password, thousandFormat }

class RegularTextField extends StatefulWidget {
  final String title;
  final TextEditingController? textEditingController;
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

  const RegularTextField._(
    this.title, {
    this.textEditingController,
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

  factory RegularTextField(
    final String title, {
    final TextEditingController? textEditingController,
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
    return RegularTextField._(
      title,
      textEditingController: textEditingController,
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

  factory RegularTextField.phone(
    final String title, {
    final TextEditingController? textEditingController,
    final String? hint,
    final String comment = "",
    final bool required = false,
    final bool enabled = true,
    final List<TextInputFormatter>? inputFormatters,
    final Function(String v)? onChanged,
    final String Function(String v)? validate,
    final bool autofocus = false,
  }) {
    return RegularTextField._(
      title,
      textEditingController: textEditingController,
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

  factory RegularTextField.password(
    final String title, {
    final TextEditingController? textEditingController,
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

    return RegularTextField._(
      title,
      textEditingController: textEditingController,
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

  factory RegularTextField.comment(
    final String title, {
    final TextEditingController? textEditingController,
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
    return RegularTextField._(
      title,
      textEditingController: textEditingController,
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

  factory RegularTextField.thousandFormat(
    final String title, {
    final TextEditingController? textEditingController,
    final String? hint,
    final String comment = "",
    final bool required = false,
    final bool enabled = true,
    final Function(String v)? onChanged,
    final int? maxLength,
    final bool autofocus = false,
    final String Function(String v)? validate,
  }) {
    return RegularTextField._(
      title,
      textEditingController: textEditingController,
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
  State<RegularTextField> createState() => _RegularTextFieldState();
}

class _RegularTextFieldState extends State<RegularTextField> {
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
                    style: const TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  if (widget.required)
                    const TextSpan(
                      text: " *",
                      style: TextStyle(color: AppColors.red, fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                ],
              ),
            ),
          if (widget.title.isNotEmpty) 10.height,
          Container(
            decoration: BoxDecoration(
              color: AppColors.foregroundSecondary,
              border: Border.all(color: errorMessage.isNotEmpty ? AppColors.red : AppColors.hintColor, width: 0.8),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                  color: AppColors.hintColor,
                                ),
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(vertical: 18),
                                isDense: true,
                                suffixText: null,
                              ),
                              autofocus: widget.autofocus,
                              inputFormatters: widget.inputFormatters,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.black,
                              ),
                              focusNode: focusNode,
                              controller: widget.textEditingController,
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
                                padding: const EdgeInsets.only(left: 16),
                                // child: (hiddenPassword ? Assets.icons.eyeOpen : Assets.icons.eyeHide).svg(
                                //   width: 24,
                                //   colorFilter: ColorFilter.mode(
                                //     hiddenPassword ? AppColors.primaryColor : AppColors.gray.withValues(alpha: 0.3),
                                //     BlendMode.srcIn,
                                //   ),
                                // ),
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
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        const Icon(Icons.clear_rounded, color: AppColors.red, size: 18),
                        4.width,
                        Expanded(
                          child: Text(
                            errorMessage,
                            style: const TextStyle(color: AppColors.red, fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          if (widget.comment.isNotEmpty)
            Container(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                widget.comment,
                style: const TextStyle(color: AppColors.gray, fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
        ],
      ),
    );
  }
}
