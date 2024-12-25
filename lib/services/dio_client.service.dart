import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:prodigal/config/global_configuration.dart';

class DioClientService {
  Dio dio;
  GlobalConfiguration config;

  DioClientService(this.dio, this.config) {
    dio
      ..options.connectTimeout = const Duration(seconds: 60)
      ..options.receiveTimeout = const Duration(seconds: 60)
      ..options.headers["Content-Type"] = "application/json"
      ..options.baseUrl = config.appConfig['base_url'];
    if (kDebugMode) dio.interceptors.add(LogInterceptor());
  }

  Future<dynamic> get(
    String uri, {
    dynamic data,
    List<Interceptor>? interceptors,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (dio.interceptors.isNotEmpty) {
        dio.interceptors.clear();
      }
      if (interceptors != null) {
        dio.interceptors.addAll(interceptors);
      }
      final response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        data: data,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (error) {
      throw SocketException(error.message);
    } on FormatException catch (error) {
      throw FormatException(error.message);
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String uri, {
    List<Interceptor>? interceptors,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (dio.interceptors.isNotEmpty) {
        dio.interceptors.clear();
      }
      if (interceptors != null) {
        dio.interceptors.addAll(interceptors);
      }
      final response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (error) {
      throw SocketException(error.message);
    } on FormatException catch (error) {
      throw FormatException(error.message);
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> put(
    String uri, {
    List<Interceptor>? interceptors,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (dio.interceptors.isNotEmpty) {
        dio.interceptors.clear();
      }
      if (interceptors != null) {
        dio.interceptors.addAll(interceptors);
      }
      final response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (error) {
      throw SocketException(error.message);
    } on FormatException catch (error) {
      throw FormatException(error.message);
    } catch (error) {
      rethrow;
    }
  }

  Future delete(
    String uri, {
    dynamic data,
    List<Interceptor>? interceptors,
  }) async {
    try {
      if (dio.interceptors.isNotEmpty) {
        dio.interceptors.clear();
      }
      if (interceptors != null) {
        dio.interceptors.addAll(interceptors);
      }
      final response = await dio.delete(
        uri,
        data: data,
      );
      return response.data;
    } on SocketException catch (error) {
      throw SocketException(error.message);
    } on FormatException catch (error) {
      throw FormatException(error.message);
    } catch (error) {
      rethrow;
    }
  }

  Future download(
    String url,
    String savePath, {
    dynamic data,
    List<Interceptor>? interceptors,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (dio.interceptors.isNotEmpty) {
        dio.interceptors.clear();
      }
      if (interceptors != null) {
        dio.interceptors.addAll(interceptors);
      }
      final response = await dio.download(
        url,
        savePath,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (error) {
      throw SocketException(error.message);
    } on FormatException catch (error) {
      throw FormatException(error.message);
    } catch (error) {
      rethrow;
    }
  }
}
