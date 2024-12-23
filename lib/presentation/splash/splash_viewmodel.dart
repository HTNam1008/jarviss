import 'package:flutter/material.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/domain/usecase/sign_in_kb_usecase.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';

class SplashViewModel extends BaseViewModel {
  final AppPreferences _appPreferences;
  final SignInKbUseCase _signInKbUseCase;
  
  SplashViewModel(this._appPreferences, this._signInKbUseCase);

  Future<String> getAccessToken() async {
    return await _appPreferences.getAccessToken();
  }

  Future<void> clearAccessToken() async {
    await _appPreferences.clearTokens();
  }

  Future<bool> isUserLoggedIn() async {
    String token = await getAccessToken();
    return token.isNotEmpty;
  }

  Future<void> signInKnowledgeBase() async {
    final token = await getAccessToken();
    if (token.isNotEmpty) {
      final result = await _signInKbUseCase.execute(SignInKbUseCaseInput(token));
      result.fold(
        (failure) => print(failure.message),
        (response) async {
          await _appPreferences.setAccessTokenKb(response.accessToken);
          await _appPreferences.setRefreshTokenKb(response.refreshToken ?? "");
        },
      );
    }
  }

  @override
  Future<void> navigateNamed(BuildContext context, String route) {
    // TODO: implement navigateNamed
    throw UnimplementedError();
  }

  @override
  Future<void> navigateReplaceNamed(BuildContext context, String route) {
    // TODO: implement navigateReplaceNamed
    throw UnimplementedError();
  }
}