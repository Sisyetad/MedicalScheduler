import 'package:dio/dio.dart';
import 'package:medical_scheduler/core/constants/api_urls.dart';
import 'package:medical_scheduler/core/network/interceptors/auth_interceptors.dart';
import 'package:medical_scheduler/core/util/session_manager.dart';

class DioClient {
  final SecureSessionManager sessionManager;
  late final Dio _dio;

  DioClient(this.sessionManager)
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiUrls.baseURL,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          responseType: ResponseType.json,
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    _dio.interceptors.addAll([
      LoggerInterceptor(),
      AuthInterceptor(sessionManager),
    ]);
  }

  Dio get dio => _dio;

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _dio.delete(
      url,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
