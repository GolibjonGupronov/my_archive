import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/services/notification_service.dart';
import 'package:my_archive/features/splash/presentation/splash_page.dart';

void logoutApp() async {
  await sl.get<PrefManager>().setToken("");
  router.go(SplashPage.tag);
  await NotificationService.deleteFCMToken;
}

mixin SafeCaller {
  Future<Either<Failure, T>> safeCall<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return Right(result);
    } catch (e, stackTrace) {
      _prettyDebugPrint(e, stackTrace);
      return Left(ServerFailure(message: _handleDioError(e)));
    }
  }

  Future<Either<Failure, T>> safeCall2<T, R extends T>(
    Future<R> Function() call, {
    required Future<void> Function(R data)? onSuccess,
  }) async {
    try {
      final result = await call();

      if (onSuccess != null) {
        try {
          await onSuccess(result);
        } catch (e, stackTrace) {
          _prettyDebugPrint(e, stackTrace);
        }
      }
      return Right(result);
    } catch (e, stackTrace) {
      _prettyDebugPrint(e, stackTrace);
      return Left(ServerFailure(message: _handleDioError(e)));
    }
  }
}

String _handleDioError(dynamic error) {
  if (error is DioException) {
    final res = error.response;
    if (res?.statusCode == 500) {
      _sendErrorToBot(error);
    }
    if (res?.statusCode == 401) {
      logoutApp();
      return tr('error_dio.login_expired');
    }
    if (res != null && res.data is Map<String, dynamic>) {
      final data = res.data as Map<String, dynamic>;
      final message = data['message'];
      if (message != null && message.toString().isNotEmpty) {
        return "$message";
      }
    }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return tr('error_dio.connection_timeout');
      case DioExceptionType.sendTimeout:
        return tr('error_dio.request_timeout');
      case DioExceptionType.receiveTimeout:
        return tr('error_dio.server_response_timeout');
      case DioExceptionType.badCertificate:
        return tr('error_dio.security_issue');
      case DioExceptionType.badResponse:
        return tr('error_dio.server_error');
      case DioExceptionType.cancel:
        return tr('error_dio.request_canceled');
      case DioExceptionType.connectionError:
        return tr('error_dio.network_error');
      case DioExceptionType.unknown:
        return tr('error_dio.unknown_error');
    }
  } else if (error is SocketException) {
    return tr('error_dio.no_internet');
  } else if (error is HttpException) {
    return error.message.isNotEmpty ? error.message : tr('error_dio.http_error');
  }

  if (kDebugMode) {
    return error.toString();
  }
  return tr('error_dio.unexpected_error');
}

void _sendErrorToBot(dynamic error) {
  try {
    BotService.sendServerError(_buildErrorText(error));
  } catch (_) {}
}

String _buildErrorText(DioException error) {
  final buffer = StringBuffer();

  buffer.writeln("🌐 URL: ${error.requestOptions.uri}");
  buffer.writeln("➡️ Method: ${error.requestOptions.method}");
  buffer.writeln("🔢 StatusCode: 500");

  if (error.requestOptions.data != null) {
    buffer.writeln("📤 RequestData: ${_short(error.requestOptions.data)}");
  }

  if (error.response?.data != null) {
    buffer.writeln("📥 ResponseData: ${_short(error.response?.data)}");
  }

  buffer.writeln("💬 Message: ${error.message}");

  return buffer.toString();
}

String _short(dynamic data, {int max = 500}) {
  final text = data.toString();
  if (text.length > max) {
    return "${text.substring(0, max)}...";
  }
  return text;
}

String getPrettyJSONString(Object jsonObject) {
  var encoder = JsonEncoder.withIndent("     ");
  return encoder.convert(jsonObject);
}

void _prettyDebugPrint(Object error, StackTrace stackTrace) {
  if (!kDebugMode) return;

  final buffer = StringBuffer();
  if (error is DioException) {
    buffer.writeln("══════════ 🌐 DIO ERROR ══════════");
    buffer.writeln("URL: ${error.requestOptions.uri}");
    buffer.writeln("Method: ${error.requestOptions.method}");
    buffer.writeln("StatusCode: ${error.response?.statusCode}");
    buffer.writeln("Message: ${error.message}");
    buffer.writeln("Data: ${error.response?.data}");
    buffer.writeln("────────── StackTrace ──────────");
    buffer.writeln(stackTrace);
    buffer.writeln("════════════════════════════════");
  } else {
    buffer.writeln("══════════ ❌ ERROR ══════════");
    buffer.writeln("🕒 Time: ${DateTime.now()}");
    buffer.writeln("📌 Type: ${error.runtimeType}");
    buffer.writeln("💬 Message: $error");
    buffer.writeln("────────── StackTrace ──────────");
    buffer.writeln(stackTrace);
    buffer.writeln("════════════════════════════════");
  }

  debugPrint(buffer.toString());
}
