import 'dart:async';

import 'package:flutter_application_1/domain/usecase/login_usecase.dart';
import 'package:flutter_application_1/presentation/base/baseviewmodel.dart';
import 'package:flutter_application_1/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel implements LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();

  var loginObject = const LoginObject(userName: '', password: '');

  final LoginUseCase? _loginUseCase; // TODO: remove ?

  LoginViewModel(this._loginUseCase);

  @override
  void start() {}

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
  }

  // outputs
  @override
  Stream<bool> get getPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get getUserNameValid => _userNameStreamController.stream.map((userName) => _isUserNameValid(userName));

  // inputs
  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  login() async {
    (await _loginUseCase!.execute(LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
              // left -> failure
              print(failure.message)},
            (data) => {
              // right -> success (data)
              print(data.customer?.name)
            }
        );
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }
}

abstract class LoginViewModelInputs {
  // three functions for actions
  setUserName(String userName);

  setPassword(String password);

  login();

  // two sink for streams
  Sink get inputUserName;

  Sink get inputPassword;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get getUserNameValid;

  Stream<bool> get getPasswordValid;
}
