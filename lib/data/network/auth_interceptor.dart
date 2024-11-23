import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/data/network/app_api.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AuthInterceptor extends Interceptor {
  final AppPreferences _appPreferences;
  final Dio _dio;

  AuthInterceptor(this._appPreferences, this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Do not add Authorization header to the refresh token request
    if (options.path != ConstantAPI.refreshToken) {
      final accessToken = await _appPreferences.getAccessToken();
      if (accessToken.isNotEmpty) {
        options.headers[Constant.AUTHORIZATION] = 'Bearer $accessToken';
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshed = await _handleRefreshToken();
        if (refreshed) {
          // Get new access token
          final accessToken = await _appPreferences.getAccessToken();
          // Update the headers
          final options = err.requestOptions;
          options.headers[Constant.AUTHORIZATION] = 'Bearer $accessToken';
          // Retry the request
          final response = await _dio.fetch(options);
          return handler.resolve(response);
        } else {
          // Refresh token failed, navigate to login
          await _appPreferences.clearTokens();
          _navigateToLogin();
          return handler.reject(err);
        }
      } catch (e) {
        // Handle error and navigate to login
        await _appPreferences.clearTokens();
        _navigateToLogin();
        return handler.reject(err);
      }
    } else {
      handler.next(err);
    }
  }

  Future<bool> _handleRefreshToken() async {
    try {
      final refreshToken = await _appPreferences.getRefreshToken();
      if (refreshToken.isEmpty) return false;

      // Use a new Dio instance without interceptors for refresh token
      Dio refreshDio = Dio();
      refreshDio.options = BaseOptions(
        baseUrl: Constant.baseUrl,
        headers: {
          Constant.CONTENT_TYPE: Constant.APPLICATION_JSON,
          Constant.ACCEPT: Constant.APPLICATION_JSON,
        },
      );

      final appServiceClient = AppServiceClient(refreshDio);

      // final refreshTokenRequest = RefreshTokenRequest(refreshToken: refreshToken);
      // Make the refresh token request
      final response = await appServiceClient.refreshToken(refreshToken);

      if (!kReleaseMode) {
            refreshDio.interceptors.add(PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseHeader: true,
              responseBody: true,
              compact: true,
            ));
          }
      // Save the new access token
      final newToken = response.token;
      await _appPreferences.setAccessToken(newToken.accessToken);

      return true;
    } catch (e) {
      print('Error while refreshing token: $e');
      return false;
    }
  }

  void _navigateToLogin() {
    // Navigate to the sign-in screen
    print("navigate to sign in");
    // Implement navigation logic here using navigatorKey or any other method
  }
}
