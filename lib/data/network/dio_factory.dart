// lib/data/network/dio_factory.dart

// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/domain/usecase/refresh_token_usecase.dart';
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
      onRequest: (options, handler) async {
        final accessToken = await _appPreferences.getAccessToken();
        if (accessToken.isNotEmpty) {
          options.headers[AUTHORIZATION] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          final refreshed = await _handleRefreshToken();
          if (refreshed) {
            final requestOptions = error.requestOptions;
            final newAccessToken = await _appPreferences.getAccessToken();
            requestOptions.headers[AUTHORIZATION] = 'Bearer $newAccessToken';
            try {
              final response = await dio.request(
                requestOptions.path,
                options: Options(
                  method: requestOptions.method,
                  headers: requestOptions.headers,
                ),
                data: requestOptions.data,
                queryParameters: requestOptions.queryParameters,
              );
              return handler.resolve(response);
            } catch (e) {
              await _appPreferences.clearTokens();
              // navigatorKey.currentState?.pushNamedAndRemoveUntil(
              //     Routes.signInRoute, (route) => false);
              return handler.next(error);
            }
          } else {
            await _appPreferences.clearTokens();
            // navigatorKey.currentState?.pushNamedAndRemoveUntil(
            //     Routes.signInRoute, (route) => false);
            return handler.next(error);
          }
        } else {
          return handler.next(error);
        }
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

  Future<bool> _handleRefreshToken() async {
    try {
      final refreshToken = await _appPreferences.getRefreshToken();
      if (refreshToken.isEmpty) return false;

      final refreshTokenUseCase = GetIt.instance<RefreshTokenUseCase>();

      final result = await refreshTokenUseCase.execute(RefreshTokenUseCaseInput(refreshToken: refreshToken));
      return result.fold(
        (failure) {
          print('Failed to refresh token: ${failure.message}');
          return false;
        },
        (token) async {
          await _appPreferences.setAccessToken(token.accessToken);
          return true;
        },
      );
    } catch (e) {
      print('Error while refreshing token: $e');
      return false;
    }
  }
}
