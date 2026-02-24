import 'package:my_archive/core/constants/constants.dart';

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

  static bool isDigit(String character) {
    if (character.isEmpty || character.length > 1) {
      return false;
    }
    return RegExp(r'[0-9]+').stringMatch(character) != null;
  }
}
