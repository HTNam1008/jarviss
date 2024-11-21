// lib/data/network/dio_factory.dart

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/data/network/auth_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Dio getDio() {
    Dio dio = Dio();

    final language = _appPreferences.getAppLanguage();

    Map<String, String> headers = {
      Constant.CONTENT_TYPE: Constant.APPLICATION_JSON,
      Constant.ACCEPT: Constant.APPLICATION_JSON,
      Constant.DEFAULT_LANGUAGE: language,
      // AUTHORIZATION will be added by the AuthInterceptor
    };

    const timeOut = 60; // 1 minute

    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: const Duration(seconds: timeOut),
      receiveTimeout: const Duration(seconds: timeOut),
      headers: headers,
    );

    // Add the AuthInterceptor
    dio.interceptors.add(AuthInterceptor(_appPreferences, dio));
    
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
