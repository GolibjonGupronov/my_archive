import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:my_archive/core/extensions/helper.dart';

extension CustomString on String {
  String? get nullIfEmpty => trim().isEmpty ? null : this;

  double get parseToDouble => double.tryParse(replaceAll(' ', '')) ?? 0.0;

  int get parseToInt => int.tryParse(replaceAll(' ', '')) ?? 0;

  String get removeSpaces => replaceAll(" ", '');

  String shortFileName({int keep = 10}) {
    if (length <= keep) return this;
    return '...${substring(length - keep)}';
  }

  String phoneFormatter({String mask = "+000 (00) 000 00 00"}) {
    if (mask.isEmpty) {
      return this;
    }
    final chars = replaceAll(RegExp(r'\D+'), '').split('');

    if (chars.length != mask.replaceAll(RegExp(r'\D+'), '').length) {
      return this;
    }

    final result = <String>[];
    var index = 0;
    for (var i = 0; i < mask.length; i++) {
      if (index >= chars.length) {
        break;
      }
      final curChar = chars[index];
      if (mask[i] == '0') {
        if (ExtensionHelper.isDigit(curChar)) {
          result.add(curChar);
          index++;
        } else {
          break;
        }
      } else {
        result.add(mask[i]);
      }
    }
    return result.join();
  }

  String get phoneReplace => replaceAll(" ", "").replaceAll("(", "").replaceAll(")", "").replaceAll("-", "");
}

extension FormattedAmountString on String? {
  double get _value => double.tryParse((this ?? '').replaceAll(' ', '')) ?? 0.0;

  String get formattedAmount => ExtensionHelper.thousandDecimalFormat(_value);

  String get formattedAmountEmpty => _value == 0 ? "" : formattedAmount;

  String get capitalize {
    final value = this ?? '';
    if (value.isEmpty) return "";
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }
}

extension HexColor on String {
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
}
