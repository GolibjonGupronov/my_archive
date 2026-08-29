import 'dart:convert';

import 'package:flutter_alice/model/alice_http_call.dart';
import 'package:flutter_alice/model/alice_http_request.dart';
import 'package:flutter_alice/model/alice_http_response.dart';
import 'package:my_archive/main.dart';

class AliceFirebase {
  AliceFirebase._();

  static const _prettyEncoder = JsonEncoder.withIndent('  ');

  static Future<T> logCall<T>({
    required String name,
    dynamic request,
    required Future<T> Function() action,
  }) async {
    final startTime = DateTime.now();
    final encodedRequestBody = _safeEncode(request);

    final call = AliceHttpCall(startTime.millisecondsSinceEpoch)
      ..method = "FIREBASE"
      ..endpoint = name
      ..server = "firebase.google.com"
      ..client = "Firebase SDK"
      ..request = (AliceHttpRequest()
        ..body = encodedRequestBody
        ..size = encodedRequestBody.length
        ..contentType = "application/json"
        ..time = startTime);

    try {
      final result = await action();
      _finishCall(call, startTime, status: 200, body: result, isError: false);
      alice.addHttpCall(call);
      return result;
    } catch (e) {
      _finishCall(call, startTime, status: 500, body: e, isError: true);
      alice.addHttpCall(call);
      rethrow;
    }
  }

  static void _finishCall(
      AliceHttpCall call,
      DateTime startTime, {
        required int status,
        required dynamic body,
        required bool isError,
      }) {
    final endTime = DateTime.now();
    final encodedBody = isError ? body.toString() : _safeEncode(body);

    call.response = AliceHttpResponse()
      ..status = status
      ..time = endTime
      ..body = encodedBody
      ..size = encodedBody.length
      ..headers = {"content-type": isError ? "text/plain" : "application/json"};

    call.duration = endTime.difference(startTime).inMilliseconds;
    call.loading = false;
  }

  static String _safeEncode(dynamic data) {
    try {
      // Avval oddiy jsonEncode bilan tekshiramiz (toJson() borligini aniqlash uchun),
      // keyin pretty formatga o'giramiz.
      final jsonString = jsonEncode(data);
      final decoded = jsonDecode(jsonString);
      return _prettyEncoder.convert(decoded);
    } catch (_) {
      return data.toString();
    }
  }
}