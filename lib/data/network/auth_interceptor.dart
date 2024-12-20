import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/data/network/app_api.dart';
import 'package:jarvis/presentation/resources/navigator_manager.dart';
import 'package:jarvis/presentation/resources/route_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AuthInterceptor extends Interceptor {
  final AppPreferences _appPreferences;
  final Dio _dio;

  AuthInterceptor(this._appPreferences, this._dio);

  bool _isKnowledgeBaseUrl(String url) {
    return url.contains(Constant.baseKnowledgeUrl);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Do not add Authorization header to the refresh token request
    if (options.path != ConstantAPI.refreshToken) {
      final accessToken = _isKnowledgeBaseUrl(options.baseUrl) 
          ? await _appPreferences.getAccessTokenKb()
          : await _appPreferences.getAccessToken();
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
        final isKbUrl = _isKnowledgeBaseUrl(err.requestOptions.baseUrl);
        final refreshed = await _handleRefreshToken(isKbUrl);
        if (refreshed) {
          // Get new access token
          final accessToken = isKbUrl 
              ? await _appPreferences.getAccessTokenKb()
              : await _appPreferences.getAccessToken();
          // Update the headers
          final options = err.requestOptions;
          options.headers[Constant.AUTHORIZATION] = 'Bearer $accessToken';
          // Retry the request
          final response = await _dio.fetch(options);
          return handler.resolve(response);
        } else {
          // Refresh token failed, navigate to login
          await _clearTokensAndNavigateToLogin(isKbUrl);
          _navigateToLogin();
          return handler.reject(err);
        }
      } catch (e) {
        // Handle error and navigate to login
        await _clearTokensAndNavigateToLogin(_isKnowledgeBaseUrl(err.requestOptions.baseUrl));
        return handler.reject(err);
      }
    } else {
      handler.next(err);
    }
  }

  Future<bool> _handleRefreshToken(bool isKbUrl) async {
    try {
      final refreshToken = isKbUrl 
          ? await _appPreferences.getRefreshTokenKb()
          : await _appPreferences.getRefreshToken();

      if (refreshToken.isEmpty) return false;
      print("refresh token: $refreshToken");
      // Use a new Dio instance without interceptors for refresh token
      Dio refreshDio = Dio();
      refreshDio.options = BaseOptions(
        baseUrl: isKbUrl ? Constant.baseKnowledgeUrl : Constant.baseUrl,
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
      if (isKbUrl) {
        await _appPreferences.setAccessTokenKb(response.token.accessToken);
      } else {
        await _appPreferences.setAccessToken(response.token.accessToken);
      }
      return true;
    } catch (e) {
      print('Error while refreshing token: $e');
      return false;
    }
  }

  Future<void> _clearTokensAndNavigateToLogin(bool isKbUrl) async {
    if (isKbUrl) {
      await _appPreferences.clearKbTokens();
    } else {
      await _appPreferences.clearTokens();
    }
    _navigateToLogin();
  } 

  void _navigateToLogin() {
    Navigator.pushNamedAndRemoveUntil(
      navigatorKey.currentContext!,
      Routes.signInRoute,
      (route) => false, // This will remove all previous routes
    );
  }
}
