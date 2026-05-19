import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor extends Interceptor {
  final Logger _logger;

  LoggingInterceptor(this._logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.i('--> ${options.method.toUpperCase()} ${options.baseUrl}${options.path}');
    if (options.queryParameters.isNotEmpty) {
      _logger.d('Query Params: ${options.queryParameters}');
    }
    if (options.data != null) {
      _logger.d('Body: ${options.data}');
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i('<-- ${response.statusCode} ${response.requestOptions.method.toUpperCase()} ${response.requestOptions.path}');
    _logger.d('Response Data: ${response.data}');
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('<-- ERROR: ${err.message}');
    if (err.response != null) {
      _logger.e('Status: ${err.response?.statusCode}');
      _logger.e('Error Response Data: ${err.response?.data}');
    }
    return handler.next(err);
  }
}
