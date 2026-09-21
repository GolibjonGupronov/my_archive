import 'dart:async';
import 'dart:math';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openUrl(String url, {LaunchMode mode = LaunchMode.externalApplication}) async =>
    await launchUrl(Uri.parse(url), mode: mode);

Future<bool?> callNumber(String phone) => launchUrl(Uri(scheme: 'tel', path: phone));

MaskTextInputFormatter phoneNumberMask({String mask = '+998 (##) ### ## ##'}) =>
    MaskTextInputFormatter(mask: mask, filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

bool canShowEmpty(List list, bool progress) => list.isEmpty && !progress;

String formatBytes(int bytes, {int decimals = 2}) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}