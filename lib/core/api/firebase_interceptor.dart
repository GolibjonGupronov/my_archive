import 'dart:convert'; // JSON encode uchun kerak
import 'package:flutter_alice/alice.dart';
import 'package:flutter_alice/model/alice_http_call.dart';
import 'package:flutter_alice/model/alice_http_request.dart';
import 'package:flutter_alice/model/alice_http_response.dart';

class FirebaseAliceLogger {
  final Alice alice;

  FirebaseAliceLogger(this.alice);

  Future<T> logCall<T>({
    required String methodName,
    dynamic requestBody,
    required Future<T> Function() action,
  }) async {
    final startTime = DateTime.now();

    final call = AliceHttpCall(startTime.millisecondsSinceEpoch);
    call.method = "FIREBASE";
    call.endpoint = methodName;
    call.server = "firebase.google.com";
    call.client = "Firebase SDK";

    // 1. Request Body-ni JSON-ga o'girish
    String encodedRequestBody;
    try {
      encodedRequestBody = jsonEncode(requestBody);
    } catch (_) {
      encodedRequestBody = requestBody.toString();
    }

    call.request = AliceHttpRequest();
    call.request?.body = encodedRequestBody;
    call.request?.contentType = "application/json";
    call.request?.time = startTime;

    try {
      final result = await action();
      final endTime = DateTime.now();

      call.response = AliceHttpResponse();
      call.response?.status = 200;
      call.response?.time = endTime;

      // 2. Response-ni JSON-ga o'girish
      String encodedResponseBody;
      try {
        // Agar result List bo'lsa, ichidagi har bir modelni toJson() qilishga urinadi
        encodedResponseBody = jsonEncode(result);
        call.response?.headers = {"content-type": "application/json"};
      } catch (e) {
        // Agar modelda toJson() bo'lmasa, shunchaki string qilamiz
        encodedResponseBody = result.toString();
        call.response?.headers = {"content-type": "text/plain"};
      }

      call.response?.body = encodedResponseBody;
      call.response?.size = encodedResponseBody.length;
      call.duration = endTime.difference(startTime).inMilliseconds;

      // Loading-ni to'xtatish
      try {
        (call as dynamic).loading = false;
      } catch (_) {}

      alice.addHttpCall(call);

      return result;
    } catch (e) {
      final endTime = DateTime.now();

      call.response = AliceHttpResponse();
      call.response?.status = 500;
      call.response?.time = endTime;
      call.response?.body = e.toString();
      call.response?.headers = {"content-type": "text/plain"};

      call.duration = endTime.difference(startTime).inMilliseconds;

      try {
        (call as dynamic).loading = false;
      } catch (_) {}

      alice.addHttpCall(call);
      rethrow;
    }
  }
}