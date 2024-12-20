import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';
import 'package:jarvis/domain/usecase/sign_in_kb_usecase.dart';

class SignInKbViewModel extends BaseViewModel 
    implements SignInKbViewModelInputs, SignInKbViewModelOutputs {
  
  final SignInKbUseCase _signInKbUseCase;
  final AppPreferences _appPreferences;
  
  final StreamController<bool> _isLoadingStreamController = StreamController<bool>();
  final StreamController<String> _errorStreamController = StreamController<String>();

  SignInKbViewModel(this._signInKbUseCase, this._appPreferences);

  @override
  Future<void> signInKb() async {
    inputIsLoading.add(true);
    final token = await _appPreferences.getAccessToken();
    
    if (token.isEmpty) {
      inputError.add("No access token found");
      inputIsLoading.add(false);
      return;
    }

    final result = await _signInKbUseCase.execute(SignInKbUseCaseInput(token));
    
    result.fold(
      (failure) {
        inputError.add(failure.message);
      },
      (token) async {
        await _appPreferences.setAccessTokenKb(token.accessToken);
        await _appPreferences.setRefreshTokenKb(token.refreshToken ?? "");
      }
    );
    
    inputIsLoading.add(false);
  }

  @override
  Sink<bool> get inputIsLoading => _isLoadingStreamController.sink;

  @override
  Sink<String> get inputError => _errorStreamController.sink;

  @override
  Stream<bool> get outputIsLoading => _isLoadingStreamController.stream.map((loading) => loading);

  @override
  Stream<String> get outputError => _errorStreamController.stream.map((error) => error);

  @override
  void start() {
    signInKb();
  }

  @override
  void dispose() {
    _isLoadingStreamController.close();
    _errorStreamController.close();
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

abstract class SignInKbViewModelInputs {
  Future<void> signInKb();
  Sink<bool> get inputIsLoading;
  Sink<String> get inputError;
}

abstract class SignInKbViewModelOutputs {
  Stream<bool> get outputIsLoading;
  Stream<String> get outputError;
}