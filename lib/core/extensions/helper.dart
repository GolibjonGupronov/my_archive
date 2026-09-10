import 'package:intl/intl.dart';
import 'package:my_archive/core/exports/core_exports.dart';

class ExtensionHelper {
  static String thousandDecimalFormat(double value) {
    var num = value.toString();
    var numberDecimal = num.substring(num.indexOf('.') + 1);
    final numberInteger = List.from(num.substring(0, num.indexOf('.')).split(''));
    int index = numberInteger.length - 3;
    while (index > 0) {
      numberInteger.insert(index, ' ');
      index -= 3;
    }
    if (numberDecimal.length > Constants.afterDot) {
      numberDecimal = numberDecimal.substring(0, Constants.afterDot);
    }
    return int.parse(numberDecimal) > 0 ? "${numberInteger.join()}.$numberDecimal" : numberInteger.join();
  }

  static String phoneFormatter({required String value, required String mask}) {
    if (mask.isEmpty) {
      return value;
    }
    final chars = value.replaceAll(RegExp(r'\D+'), '').split('');

    if (chars.length != mask.replaceAll(RegExp(r'\D+'), '').length) {
      return value;
    }

    final result = <String>[];
    var index = 0;
    for (var i = 0; i < mask.length; i++) {
      if (index >= chars.length) {
        break;
      }
      final curChar = chars[index];
      if (mask[i] == '0') {
        if (_isDigit(curChar)) {
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

  static DateTime? toDateTime(String date) {
    final value = date.trim();
    if (value.isEmpty) return null;

    final isoDate = DateTime.tryParse(value);
    if (isoDate != null) return isoDate;

    for (final format in _cachedFormats) {
      try {
        return format.parseStrict(value);
      } catch (_) {}
    }
    return null;
  }

  static String formatTo({required String outputFormat, required DateTime? date}) =>
      date == null ? "--" : DateFormat(outputFormat).format(date);

  static String? fromHex(String value) {
    var hex = value.replaceAll('#', '').trim();
    if (hex.length == 3) {
      hex = hex.split('').map((e) => '$e$e').join();
    }
    if (hex.length == 6) {
      return 'FF$hex';
    }
    if (hex.length == 8) return hex;
    return null;
  }
}

bool _isDigit(String character) {
  if (character.isEmpty || character.length > 1) {
    return false;
  }
  return RegExp(r'[0-9]+').stringMatch(character) != null;
}

final List<DateFormat> _cachedFormats = [
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