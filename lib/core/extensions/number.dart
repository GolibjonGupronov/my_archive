import 'package:flutter/material.dart';
import 'package:my_archive/core/exports/core_exports.dart';

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
  String formatTo(String outputFormat) => ExtensionHelper.formatTo(outputFormat: outputFormat, date: _toDateTime);
  String get formattedDate => ExtensionHelper.formatTo(outputFormat: 'dd.MM.yyyy', date: _toDateTime);
  String get formattedTime => ExtensionHelper.formatTo(outputFormat: 'HH:mm', date: _toDateTime);
  String get formattedDateTime => ExtensionHelper.formatTo(outputFormat: 'dd.MM.yyyy HH:mm', date: _toDateTime);
}

extension FormattedAmountInt on num? {
  double get _value => (this ?? 0).toDouble();
  String get formattedAmount => ExtensionHelper.thousandDecimalFormat(_value);
  String get formattedAmountEmpty => _value == 0 ? "" : formattedAmount;
}

extension CustomDouble on double {
  double fixed({int fix = Constants.afterDot}) => double.parse(toStringAsFixed(fix));
}

extension SizedBoxExtensions on num {
  SizedBox get height => SizedBox(height: toDouble().h);
  SizedBox get width => SizedBox(width: toDouble().w);
  SizedBox get box => SizedBox(width: toDouble().w, height: toDouble().w);
}
