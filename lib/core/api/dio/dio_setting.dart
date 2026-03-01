import 'package:dio/dio.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/main.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({"token": sl.get<PrefManager>().getToken, 'lang': sl.get<PrefManager>().getLanguage.key});
    super.onRequest(options, handler);
  }
}

class DioSetting {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseUrl,
        connectTimeout: Constants.dioTimeOut,
        receiveTimeout: Constants.dioTimeOut,
        sendTimeout: Constants.dioTimeOut,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(CustomInterceptor());
    dio.interceptors.add(alice.getDioInterceptor());

    return dio;
  }
}
