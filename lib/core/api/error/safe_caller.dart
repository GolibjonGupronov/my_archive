import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:my_archive/core/api/error/base_response.dart';
import 'package:my_archive/core/api/error/failure.dart';
import 'package:my_archive/core/app_router/app_router.dart';
import 'package:my_archive/core/local_storage/pref_manager/pref_manager.dart';
import 'package:my_archive/core/services/bot/bot_service.dart';
import 'package:my_archive/core/services/service_locator/service_locator.dart';
import 'package:my_archive/core/utils/either.dart';
import 'package:my_archive/features/splash/presentation/splash_page.dart';

mixin SafeCaller {
  Future<Either<Failure, R>> safeBaseCall<R>({
    required Future<BaseResponse> Function() call,
    required R Function(dynamic data) mapper,
  }) async {
    try {
      final response = await call();

      if (response.success && response.data != null) {
        return Right(mapper(response.data));
      } else {
        return Left(ServerFailure(message: response.message));
      }
    } catch (e) {
      return Left(ServerFailure(message: _handleDioError(e)));
    }
  }

  Future<Either<Failure, T>> safeCall<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: _handleDioError(e)));
    }
  }

  String _handleDioError(dynamic error) {
    if (error is DioException) {
      final res = error.response;
      if (res?.statusCode == 500) {
        _sendErrorToBot(error);
      }
      if (res?.statusCode == 401) {
        logout();
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

void logout() async {
  await sl.get<PrefManager>().setToken("");
  router.go(SplashPage.tag);
}
