import 'dart:async';
import 'dart:math';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_archive/core/enums/common.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openUrl(String url, {LaunchMode mode = LaunchMode.externalApplication}) async =>
    await launchUrl(Uri.parse(url), mode: mode);

Future<bool?> callNumber(String phone) => launchUrl(Uri(scheme: 'tel', path: phone));

MaskTextInputFormatter phoneNumberMask({String mask = '+998 (##) ### ## ##'}) =>
    MaskTextInputFormatter(mask: mask, filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

bool canShowEmpty(List list, bool progress) => list.isEmpty && !progress;

String formatBytes(num value, {int decimals = 2, ByteUnit inputUnit = ByteUnit.b}) {
  if (value <= 0) return "0 ${ByteUnit.b.label}";

  num valueInBytes = value * inputUnit.multiplier;

  var i = (log(valueInBytes) / log(1024)).floor();
  if (i >= ByteUnit.values.length) i = ByteUnit.values.length - 1;
  if (i < 0) i = 0;

  final unit = ByteUnit.values[i];
  return '${(valueInBytes / unit.multiplier).toStringAsFixed(decimals)} ${unit.label}';
}