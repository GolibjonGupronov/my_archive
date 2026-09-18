import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

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
