// lib/presentation/authentication/sign_out/sign_out_viewmodel.dart

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/domain/usecase/sign_out_usecase.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';

class SignOutViewModel extends BaseViewModel
    implements SignOutViewModelInputs, SignOutViewModelOutputs {
  final StreamController<String> _errorStreamController =
      StreamController<String>.broadcast();

  final StreamController<bool> _signOutStreamController =
      StreamController<bool>.broadcast();

  final SignOutUseCase _signOutUseCase;
  final AppPreferences _appPreferences;

  SignOutViewModel(this._signOutUseCase, this._appPreferences);

  @override
  void start() {}

  @override
  void dispose() {
    _errorStreamController.close();
    _signOutStreamController.close();
  }

  // Outputs
  @override
  Stream<String> get errorStream => _errorStreamController.stream;

  @override
  Stream<bool> get signOutStream => _signOutStreamController.stream;

  @override
  Future<void> signOut() async {
    (await _signOutUseCase.execute(SignOutUseCaseInput())).fold(
      (failure) {
       print('SignOut failed: ${failure.message}');
        _errorStreamController.add(failure.message); // Notify listeners about the error
        _signOutStreamController.add(false); // Indicate sign-out failure
      },
      (_) async {
        print('SignOut successful.');
        await _appPreferences.clearTokens(); // Clear tokens from secure storage
        _signOutStreamController.add(true); // Indicate sign-out success
      },
    );
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

abstract class SignOutViewModelInputs {
  Future<void> signOut();
}

abstract class SignOutViewModelOutputs {
  Stream<String> get errorStream;

  Stream<bool> get signOutStream;
}
