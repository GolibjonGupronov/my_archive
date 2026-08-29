import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openUrl(String url, {LaunchMode mode = LaunchMode.externalApplication}) async =>
    await launchUrl(Uri.parse(url), mode: mode);

Future<bool?> callNumber(String phone) async => await launchUrl(Uri(scheme: 'tel', path: phone));

MaskTextInputFormatter phoneNumberMask({String mask = '+998 (##) ### ## ##'}) =>
    MaskTextInputFormatter(mask: mask, filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

bool canShowEmpty(List list, bool progress) => list.isEmpty && !progress;

void logger(Object? message) {
  if (kDebugMode) {
    debugPrint('[DEBUG] $message');
  }
}

void loggerStack({StackTrace? stackTrace, String? label, int? maxFrames}) {
  if (kDebugMode) {
    debugPrintStack(stackTrace: stackTrace, label: label, maxFrames: maxFrames);
  }
}

void devLogger(
  String message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  String name = '',
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  if (kDebugMode) {
    dev.log(message,
        time: time, sequenceNumber: sequenceNumber, level: level, name: name, zone: zone, error: error, stackTrace: stackTrace);
  }
}
