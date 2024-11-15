import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/domain/usecase/login_usecase.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';
import 'package:jarvis/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController<String> _emailStreamController =
      StreamController<String>.broadcast();

  final StreamController<String> _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController<String> _errorStreamController =
      StreamController<String>.broadcast();

  final StreamController<bool> _loginStreamController =
      StreamController<bool>.broadcast();

  var loginObject = const LoginObject(email: '', password: '');

  final LoginUseCase _loginUseCase;

  final AppPreferences _appPreferences;

  LoginViewModel(this._loginUseCase, this._appPreferences);

  @override
  void start() {}

  @override
  void dispose() {
    _emailStreamController.close();
    _passwordStreamController.close();
    _errorStreamController.close();
    _loginStreamController.close();
  }

  // Outputs
  @override
  Stream<bool> get isEmailValid =>
      _emailStreamController.stream.map(_isEmailValid);

  @override
  Stream<bool> get isPasswordValid =>
      _passwordStreamController.stream.map(_isPasswordValid);

  Stream<String> get errorStream => _errorStreamController.stream;

  @override
  Stream<bool> get loginStream => _loginStreamController.stream;

  // Inputs
  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Future<void> login() async {
    (await _loginUseCase.execute(
      LoginUseCaseInput(loginObject.email, loginObject.password),
    ))
        .fold(
      (failure) {
        print('Login failed: ${failure.message}');
        _errorStreamController.add(failure.message); 
        _loginStreamController.add(false);
      },
      (token) {
        print('Login successful. Access Token: ${token.accessToken}');
        _appPreferences.setToken(token.accessToken); 
      _loginStreamController.add(true); 
      },
    );
  }

  @override
  void setEmail(String email) {
    inputEmail.add(email);
    loginObject = loginObject.copyWith(email: email);
  }

  @override
  void setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
  }

  bool _isEmailValid(String email) {
    return email.isNotEmpty && email.contains('@');
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  @override
  Future<void> navigateReplaceNamed(BuildContext context, String route) async {
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Future<void> navigateNamed(BuildContext context, String route) async {
    Navigator.pushNamed(context, route);
  }
}

abstract class LoginViewModelInputs {
  void setEmail(String email);

  void setPassword(String password);

  Future<void> login();

  // Sink cho Streams
  Sink get inputEmail;

  Sink get inputPassword;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get isEmailValid;

  Stream<bool> get isPasswordValid;

  Stream<bool> get loginStream;
}
