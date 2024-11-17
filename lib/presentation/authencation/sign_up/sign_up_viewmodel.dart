import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/domain/usecase/sign_up_usecase.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';
import 'package:jarvis/presentation/common/freezed_data_classes.dart';

class SignUpViewModel extends BaseViewModel
    implements SignUpViewModelInputs, SignUpViewModelOutputs {
  final StreamController<String> _emailStreamController =
      StreamController<String>.broadcast();

  final StreamController<String> _passwordStreamController =
      StreamController<String>.broadcast();
  
  final StreamController<String> _usernameStreamController =
      StreamController<String>.broadcast();

  final StreamController<String> _errorStreamController =
      StreamController<String>.broadcast();

  final StreamController<bool> _signUpStreamController =
      StreamController<bool>.broadcast();

  var signUpObject = const SignUpObject(email: '', password: '', username: '');

  final SignUpUseCase _signUpUseCase;

  final AppPreferences _appPreferences;

  SignUpViewModel(this._signUpUseCase, this._appPreferences);

  @override
  void start() {}

  @override
  void dispose() {
    _emailStreamController.close();
    _passwordStreamController.close();
    _usernameStreamController.close();
    _errorStreamController.close();
    _signUpStreamController.close();
  }

  // Outputs
  @override
  Stream<bool> get isEmailValid =>
      _emailStreamController.stream.map(_isEmailValid);

  @override
  Stream<bool> get isPasswordValid =>
      _passwordStreamController.stream.map(_isPasswordValid);

  @override
  Stream<bool> get isUsernameValid =>
      _usernameStreamController.stream.map(_isUsernameValid);


  Stream<String> get errorStream => _errorStreamController.stream;

  @override
  Stream<bool> get signUpStream => _signUpStreamController.stream;

  // Inputs
  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  Future<void> signUp() async {
    (await _signUpUseCase.execute(
      SignUpUseCaseInput(signUpObject.email, signUpObject.password, signUpObject.username),
    ))
        .fold(
      (failure) {
        print('Login failed: ${failure.message}');
        _errorStreamController.add(failure.message);
        _signUpStreamController.add(false);
      },
      (user) {
        print('Login successful. User: $user');
        // _appPreferences.setToken(token.accessToken); 
        _signUpStreamController.add(true); 
      },
    );
  }

  @override
  void setEmail(String email) {
    inputEmail.add(email);
    signUpObject = signUpObject.copyWith(email: email);
  }

  @override
  void setPassword(String password) {
    inputPassword.add(password);
    signUpObject = signUpObject.copyWith(password: password);
  }

  @override
  void setUsername(String username) {
    inputUsername.add(username);
    signUpObject = signUpObject.copyWith(username: username);
  }

  bool _isEmailValid(String email) {
    return email.isNotEmpty && email.contains('@');
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  bool _isUsernameValid(String username) {
    return username.isNotEmpty;
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

abstract class SignUpViewModelInputs {
  void setEmail(String email);

  void setPassword(String password);

  void setUsername(String username);

  Future<void> signUp();

  // Sink cho Streams
  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputUsername;
}

abstract class SignUpViewModelOutputs {
  Stream<bool> get isEmailValid;

  Stream<bool> get isPasswordValid;

  Stream<bool> get isUsernameValid;

  Stream<bool> get signUpStream;
}
