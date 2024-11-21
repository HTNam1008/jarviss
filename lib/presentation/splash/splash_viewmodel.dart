import 'package:flutter/src/widgets/framework.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';

class SplashViewModel extends BaseViewModel {
  final AppPreferences _appPreferences;

  SplashViewModel(this._appPreferences);

  Future<String> getAccessToken() async {
    return await _appPreferences.getAccessToken();
  }

  // Thêm các phương thức khác nếu cần
  Future<void> clearAccessToken() async {
    await _appPreferences.clearTokens();
  }

  Future<bool> isUserLoggedIn() async {
    String token = await getAccessToken();
    return token.isNotEmpty;
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