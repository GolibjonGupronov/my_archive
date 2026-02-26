import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:my_archive/core/constants/constants.dart';
import 'package:my_archive/core/extensions/helper.dart';

/// Integer
extension CustomInt on int {
  double fixed({int fix = Constants.afterDot}) => double.parse(toStringAsFixed(fix));

  String get toMmSs {
    final minutes = (this ~/ 60).toString().padLeft(2, '0');
    final seconds = (this % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

extension FormattedIntDateTime on int? {
  DateTime? get _toDateTime => this == null ? null : DateTime.fromMillisecondsSinceEpoch(this!);

  String get formattedDate => _toDateTime == null ? "" : DateFormat('dd.MM.yyyy').format(_toDateTime!);

  String get formattedTime => _toDateTime == null ? "" : DateFormat('HH:mm').format(_toDateTime!);

  String get formattedDateTime => _toDateTime == null ? "" : DateFormat('dd.MM.yyyy HH:mm').format(_toDateTime!);
}

extension FormattedAmountInt on int? {
  double get _value => (this ?? 0).toDouble();

  String get formattedAmount => ExtensionHelper.thousandDecimalFormat(_value);

  String get formattedAmountEmpty => _value == 0 ? "" : formattedAmount;
}

/// Double
extension CustomDouble on double {
  double fixed({int fix = Constants.afterDot}) => double.parse(toStringAsFixed(fix));
}

extension FormattedAmountDouble on double? {
  double get _value => this ?? 0.0;

  String get formattedAmount => ExtensionHelper.thousandDecimalFormat(_value);

  String get formattedAmountEmpty => _value == 0 ? "" : formattedAmount;
}

/// Number
extension SizedBoxExtensions on num {
  SizedBox get height => SizedBox(height: toDouble().h);

  SizedBox get width => SizedBox(width: toDouble().w);

  SizedBox get box => SizedBox(width: toDouble().w, height: toDouble().w);
}
