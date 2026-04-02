import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:my_archive/core/core_exports.dart';

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

  String phoneFormatter({String mask = "+### (##) ###-##-##"}) {
    final digits = replaceAll(RegExp(r'\D'), '');
    int digitIndex = digits.length - 1;

    final buffer = StringBuffer();

    for (int i = mask.length - 1; i >= 0; i--) {
      final maskChar = mask[i];

      if (maskChar == '#') {
        if (digitIndex >= 0) {
          buffer.write(digits[digitIndex]);
          digitIndex--;
        } else {
          break;
        }
      } else {
        buffer.write(maskChar);
      }
    }

    return buffer.toString().split('').reversed.join();
  }

  String get phoneReplace => replaceAll(" ", "").replaceAll("(", "").replaceAll(")", "").replaceAll("-", "");
}

extension FormattedAmountString on String? {
  double get _value => double.tryParse((this ?? '').replaceAll(' ', '')) ?? 0.0;

  String get formattedAmount => ExtensionHelper.thousandDecimalFormat(_value);

  String get formattedAmountEmpty => _value == 0 ? "" : formattedAmount;
}

extension HexColorStrinng on String {
  Color? get fromHex {
    var hex = replaceAll('#', '').trim();

    if (hex.length == 3) {
      hex = hex.split('').map((e) => '$e$e').join();
    }

    if (hex.length == 6) {
      hex = 'FF$hex';
    }

    if (hex.length != 8) return null;

    return Color(int.tryParse(hex, radix: 16) ?? 0xFFFFFFFF);
  }
}

extension StringDateParsing on String {
  static final List<DateFormat> _cachedFormats = [
    "dd.MM.yyyy HH:mm",
    "dd/MM/yyyy HH:mm",
    "yyyy-MM-dd HH:mm",
    "yyyy.MM.dd HH:mm",
    "MM-dd-yyyy HH:mm",
    "dd.MM.yyyy HH:mm:ss",
    "dd/MM/yyyy HH:mm:ss",
    "yyyy-MM-dd HH:mm:ss",
    "yyyy.MM.dd HH:mm:ss",
    "MM-dd-yyyy HH:mm:ss",
    "dd.MM.yyyy",
    "dd/MM/yyyy",
    "yyyy-MM-dd",
    "yyyy.MM.dd",
    "MM-dd-yyyy",
    "yyyy-MM-ddTHH:mm:ssZ"
  ].map((e) => DateFormat(e)).toList();

  DateTime? get toDateTime {
    final value = trim();
    if (value.isEmpty) return null;

    for (final format in _cachedFormats) {
      try {
        return format.parseStrict(value);
      } catch (_) {}
    }
    return null;
  }

  String formatTo(String outputFormat) {
    final date = toDateTime;
    if (date == null) return "--";

    return DateFormat(outputFormat).format(date);
  }
}
