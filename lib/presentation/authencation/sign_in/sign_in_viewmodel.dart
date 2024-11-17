import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/domain/usecase/sign_in_usecase.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';
import 'package:jarvis/presentation/common/freezed_data_classes.dart';

class SignInViewModel extends BaseViewModel
    implements SignInViewModelInputs, SignInViewModelOutputs {
  final StreamController<String> _emailStreamController =
      StreamController<String>.broadcast();

  final StreamController<String> _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController<String> _errorStreamController =
      StreamController<String>.broadcast();

  final StreamController<bool> _signInStreamController =
      StreamController<bool>.broadcast();

  var signInObject = const SignInObject(email: '', password: '');

  final SignInUseCase _signInUseCase;

  final AppPreferences _appPreferences;

  SignInViewModel(this._signInUseCase, this._appPreferences);

  @override
  void start() {}

  @override
  void dispose() {
    _emailStreamController.close();
    _passwordStreamController.close();
    _errorStreamController.close();
    _signInStreamController.close();
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
  Stream<bool> get signInStream => _signInStreamController.stream;

  // Inputs
  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Future<void> signIn() async {
    (await _signInUseCase.execute(
      SignInUseCaseInput(signInObject.email, signInObject.password),
    ))
        .fold(
      (failure) {
        print('SignIn failed: ${failure.message}');
        _errorStreamController.add(failure.message); 
        _signInStreamController.add(false);
      },
      (token) {
        print('SignIn successful. Access Token: ${token.accessToken}');
        _appPreferences.setAccessToken(token.accessToken); 
        _appPreferences.setRefreshToken(token.refreshToken); 
        _signInStreamController.add(true); 
      },
    );
  }

  @override
  void setEmail(String email) {
    inputEmail.add(email);
    signInObject = signInObject.copyWith(email: email);
  }

  @override
  void setPassword(String password) {
    inputPassword.add(password);
    signInObject = signInObject.copyWith(password: password);
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

abstract class SignInViewModelInputs {
  void setEmail(String email);

  void setPassword(String password);

  Future<void> signIn();

  // Sink cho Streams
  Sink get inputEmail;

  Sink get inputPassword;
}

abstract class SignInViewModelOutputs {
  Stream<bool> get isEmailValid;

  Stream<bool> get isPasswordValid;

  Stream<bool> get signInStream;
}
