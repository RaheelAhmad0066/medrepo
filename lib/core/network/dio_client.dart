import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:medrep_pro/config/env/app_env.dart';
import 'package:medrep_pro/core/constants/app_constants.dart';
import 'package:medrep_pro/core/error/exceptions.dart';
import 'package:medrep_pro/core/network/interceptors/auth_interceptor.dart';
import 'package:medrep_pro/core/network/interceptors/logging_interceptor.dart';
import 'package:medrep_pro/core/services/secure_storage_service.dart';

class DioClient {
  final Dio _dio;

  DioClient({
    required SecureStorageService secureStorage,
    required Logger logger,
    ClerkTokenProvider? clerkTokenProvider,
    Dio? dio,
  }) : _dio = dio ?? Dio() {
    _dio
      ..options.baseUrl = AppEnv.apiBaseUrl
      ..options.connectTimeout = AppConstants.connectTimeout
      ..options.receiveTimeout = AppConstants.receiveTimeout
      ..options.sendTimeout = AppConstants.sendTimeout
      ..options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

    _dio.interceptors.addAll([
      AuthInterceptor(secureStorage, _dio, clerkTokenProvider),
      LoggingInterceptor(logger),
    ]);
  }

  /// Helper to send GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Helper to send POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Helper to send PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Helper to send DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  AppException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException(
          message: 'Connection timed out. Please check your internet connectivity.',
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final statusMessage = error.response?.data?['message'] ?? error.message;
        if (statusCode == 401 || statusCode == 403) {
          return AuthException(
            message: statusMessage ?? 'Unauthorized access.',
            statusCode: statusCode,
          );
        }
        return ServerException(
          message: statusMessage ?? 'An error occurred on the server.',
          statusCode: statusCode,
        );
      case DioExceptionType.cancel:
        return const NetworkException(message: 'Request was cancelled.');
      case DioExceptionType.badCertificate:
        return const NetworkException(message: 'Invalid server certificate.');
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return const NetworkException(
            message: 'No internet connection. Please verify your connection status.',
          );
        }
        return ServerException(
          message: error.message ?? 'An unknown error occurred.',
        );
    }
  }
}
