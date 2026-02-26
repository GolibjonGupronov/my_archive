import 'package:dio/dio.dart';

class MockResponseConfig {
  final dynamic data;
  final String? message;
  final int statusCode;
  final int waitSeconds;

  MockResponseConfig({
    required this.data,
    this.message,
    this.statusCode = 200,
    this.waitSeconds = 2,
  });
}

class DioMock {
  final MockResponseConfig mockResponses;
  final Dio dio;

  DioMock({required this.mockResponses, required this.dio});

  Future<Response> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _buildMockResponse(
      method: 'GET',
      path: path,
      queryParameters: queryParameters,
    );
  }

  Future<Response> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _buildMockResponse(
      method: 'POST',
      path: path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<Response> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _buildMockResponse(
      method: 'PUT',
      path: path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<Response> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _buildMockResponse(
      method: 'PATCH',
      path: path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<Response> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _buildMockResponse(
      method: 'DELETE',
      path: path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<Response> _buildMockResponse({
    required String method,
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final MockResponseConfig config = mockResponses;

    final requestOptions =
        RequestOptions(path: "MOCK--------$path", method: method, data: data, queryParameters: queryParameters, baseUrl: '');

    if (dio.interceptors.isNotEmpty) {
      for (var interceptor in dio.interceptors) {
        try {
          // final interceptorName = interceptor.runtimeType.toString();
          // if (interceptorName == 'AliceDioInterceptor') {
          //   continue;
          // }
          await _callOnRequest(interceptor, requestOptions);
        } catch (_) {}
      }
    }

    await Future.delayed(Duration(seconds: config.waitSeconds));

    if (config.statusCode != 200) {
      final dioException = DioException(
        requestOptions: requestOptions,
        response: Response(
          requestOptions: requestOptions,
          statusCode: config.statusCode,
          statusMessage: config.message,
          headers: Headers.fromMap({
            'content-type': ['application/json; charset=utf-8'],
          }),
          data: {
            "message": config.message,
          },
        ),
        type: DioExceptionType.badResponse,
        message: config.message,
      );

      if (dio.interceptors.isNotEmpty) {
        for (var interceptor in dio.interceptors) {
          try {
            // final interceptorName = interceptor.runtimeType.toString();
            // if (interceptorName == 'AliceDioInterceptor') {
            //   continue;
            // }
            await _callOnError(interceptor, dioException);
          } catch (_) {}
        }
      }

      throw dioException;
    }
    final response = Response(
      requestOptions: requestOptions,
      statusCode: config.statusCode,
      statusMessage: "OK",
      headers: Headers.fromMap({
        'content-type': ['application/json; charset=utf-8'],
      }),
      data: _normalizeData(config.data),
    );

    if (dio.interceptors.isNotEmpty) {
      for (var interceptor in dio.interceptors) {
        try {
          // final interceptorName = interceptor.runtimeType.toString();
          // if (interceptorName == 'AliceDioInterceptor') {
          //   continue;
          // }
          await _callOnResponse(interceptor, response);
        } catch (_) {}
      }
    }

    return response;
  }

  Future<void> _callOnRequest(Interceptor interceptor, RequestOptions options) async {
    final handler = _MockRequestInterceptorHandler((updatedOptions) {
      options.headers = updatedOptions.headers;
      options.data = updatedOptions.data;
      options.queryParameters = updatedOptions.queryParameters;
    });

    interceptor.onRequest(options, handler);
  }

  Future<void> _callOnResponse(Interceptor interceptor, Response response) async {
    final handler = _MockResponseInterceptorHandler((res) {
      response.data = res.data;
      response.statusCode = res.statusCode;
    });

    interceptor.onResponse(response, handler);
  }

  Future<void> _callOnError(Interceptor interceptor, DioException err) async {
    final handler = _MockErrorInterceptorHandler((e) {
      throw e;
    });
    interceptor.onError(err, handler);
  }

  dynamic _normalizeData(dynamic data) {
    if (data == null) return null;

    if (data is String || data is num || data is bool) {
      return data;
    }

    if (data is Map) {
      return data.map((key, value) => MapEntry(key.toString(), _normalizeData(value)));
    }

    if (data is List) {
      return data.map((e) => _normalizeData(e)).toList();
    }

    try {
      return _normalizeData(data.toJson());
    } catch (_) {
      return data;
    }
  }
}

class _MockRequestInterceptorHandler extends RequestInterceptorHandler {
  final void Function(RequestOptions) onNext;

  _MockRequestInterceptorHandler(this.onNext);

  @override
  void next(RequestOptions requestOptions) {
    onNext(requestOptions);
  }

  @override
  void reject(DioException error, [bool requestIsNext = false]) {
    throw error;
  }

  @override
  void resolve(Response response, [bool requestIsNext = false]) {}
}

class _MockResponseInterceptorHandler extends ResponseInterceptorHandler {
  final void Function(Response) onNext;

  _MockResponseInterceptorHandler(this.onNext);

  @override
  void next(Response response) {
    onNext(response);
  }

  @override
  void reject(DioException error, [bool requestIsNext = false]) {
    throw error;
  }

  @override
  void resolve(Response response, [bool requestIsNext = false]) {
    onNext(response);
  }
}

class _MockErrorInterceptorHandler extends ErrorInterceptorHandler {
  final void Function(DioException) onNext;

  _MockErrorInterceptorHandler(this.onNext);

  @override
  void next(DioException err) {
    onNext(err);
  }

  @override
  void reject(DioException error) {
    throw error;
  }

  @override
  void resolve(Response response) {}
}

extension DioExtension on Dio {
  DioMock mock({
    required dynamic data,
    String message = "Dio Mock Error",
    int statusCode = 200,
    int waitSeconds = 2,
  }) =>
      DioMock(
        mockResponses: MockResponseConfig(
          data: data,
          message: message,
          statusCode: statusCode,
          waitSeconds: waitSeconds,
        ),
        dio: this,
      );
}
