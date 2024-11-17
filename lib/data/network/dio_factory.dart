// lib/data/network/dio_factory.dart

// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/app/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Dio getDio() {
    Dio dio = Dio();

    final language = _appPreferences.getAppLanguage();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      DEFAULT_LANGUAGE: language,
      // AUTHORIZATION sẽ được thêm thông qua interceptor
    };

    const timeOut = 60; // 1 phút

    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: const Duration(seconds: timeOut),
      receiveTimeout: const Duration(seconds: timeOut),
      headers: headers,
    );

    // Thêm interceptor để thêm token vào header nếu có
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = _appPreferences.getToken();
        if (token.isNotEmpty) {
          options.headers[AUTHORIZATION] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) {
        return handler.next(error);
      },
    ));

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        compact: true,
      ));
    }

    return dio;
  }
}
