import 'package:flutter/cupertino.dart';
import 'package:my_archive/core/exports/core_exports.dart';

extension CustomString on String {
  String get capitalize {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String get getFirstLetters => isEmpty ? "" : trim().split(RegExp(r'\s+')).map((word) => word[0].toUpperCase()).join();
  String? get nullIfEmpty => trim().isEmpty ? null : this;
  double get parseToDouble => double.tryParse(replaceAll(' ', '')) ?? 0.0;
  int get parseToInt => int.tryParse(replaceAll(' ', '')) ?? 0;
  String get removeSpaces => replaceAll(" ", '');

  String shortFileName({int keep = 10}) {
    if (length <= keep) return this;
    return '...${substring(length - keep)}';
  }

  String phoneFormatter({String mask = "+000 (00) 000-00-00"}) => ExtensionHelper.phoneFormatter(value: this, mask: mask);

  String get phoneReplace => replaceAll(" ", "").replaceAll("(", "").replaceAll(")", "").replaceAll("-", "");
  Color? get fromHex {
    final hex = ExtensionHelper.fromHex(this);
    if (hex == null) return null;
    return Color(int.tryParse(hex, radix: 16) ?? 0xFFFFFFFF);
  }

  DateTime? get toDateTime => ExtensionHelper.toDateTime(this);
  String formatTo(String outputFormat) => ExtensionHelper.formatTo(outputFormat: outputFormat, date: toDateTime);
  String get formattedDate => ExtensionHelper.formatTo(outputFormat: 'dd.MM.yyyy', date: toDateTime);
  String get formattedTime => ExtensionHelper.formatTo(outputFormat: 'HH:mm', date: toDateTime);
  String get formattedDateTime => ExtensionHelper.formatTo(outputFormat: 'dd.MM.yyyy HH:mm', date: toDateTime);
}

extension FormattedAmountString on String? {
  double get _value => double.tryParse((this ?? '').replaceAll(' ', '')) ?? 0.0;
  String get formattedAmount => ExtensionHelper.thousandDecimalFormat(_value);
  String get formattedAmountEmpty => _value == 0 ? "" : formattedAmount;
}
