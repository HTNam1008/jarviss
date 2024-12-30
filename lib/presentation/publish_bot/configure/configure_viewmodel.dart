import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/domain/usecase/disconnect_bot_integration_usecase.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';
import 'package:jarvis/domain/usecase/verify_slack_bot_integration_usecase.dart';
import 'package:jarvis/domain/usecase/verify_telegram_bot_integration_usecase.dart';
import 'package:jarvis/domain/usecase/verify_messenger_bot_integration_usecase.dart';
import 'package:jarvis/presentation/publish_bot/publish_bot_viewmodel.dart';

class ConfigureViewModel extends BaseViewModel implements ConfigureViewModelInputs, ConfigureViewModelOutputs {
  final VerifySlackBotIntegrationUsecase _verifySlackUsecase;
  final VerifyTelegramBotIntegrationUsecase _verifyTelegramUsecase;
  final VerifyMessengerBotIntegrationUsecase _verifyMessengerUsecase;
  final DisconnectBotIntegrationUsecase _disconnectBotIntegrationUsecase;

  final StreamController<String> _errorController = StreamController<String>();
  final StreamController<bool> _isLoadingController = StreamController<bool>();

  Platform? platform;
  Map<String, TextEditingController> controllers = {};

  ConfigureViewModel(
    this._verifySlackUsecase,
    this._verifyTelegramUsecase,
    this._verifyMessengerUsecase, 
    this._disconnectBotIntegrationUsecase,
  );

  void init(Platform platform) {
    this.platform = platform;
  }

  String getStepTitle(int step) {
    return 'Step $step: ${platform?.name} ${step == 1 ? 'copylink' : 'information'}';
  }

  String getEventUrl(String type) {
    const baseUrl = '${Constant.baseKnowledgeUrl}/kb-core/v1';
    switch (type) {
      case 'slack_oauth':
        return '$baseUrl/bot-integration/slack/auth/${platform?.assistantId}';
      case 'slack_event':
        return '$baseUrl/hook/slack/${platform?.assistantId}';
      case 'slack_slash':
        return '$baseUrl/hook/slack/slash/${platform?.assistantId}';
      case 'messenger_callback':
        return '$baseUrl/hook/messenger/${platform?.assistantId}';
      default:
        return '';
    }
  }

  Future<bool> verifyBot(Map<String, String> values) async {
    inputIsLoading.add(true);
    try {
      final result = await _verifyPlatformBot(values);
      return result.fold(
        (failure) {
          inputError.add(failure.message);
          return false;
        },
        (_) => true,
      );
    } catch (e) {
      inputError.add(e.toString());
      return false;
    } finally {
      inputIsLoading.add(false);
    }
  }

  Future<Either<Failure, void>> _verifyPlatformBot(Map<String, String> values) {
    switch (platform?.type) {
      case 'slack':
        return _verifySlackUsecase.execute(
          VerifyBotSlackIntegrationUsecaseInput(
            botToken: values['Bot Token'] ?? '',
            clientId: values['Client ID'] ?? '',
            clientSecret: values['Client Secret'] ?? '',
            signingSecret: values['Signing Secret'] ?? '',
          ),
        );
      case 'telegram':
        return _verifyTelegramUsecase.execute(
          VerifyBotTelegramIntegrationUsecaseInput(
            botToken: values['Bot Token'] ?? '',
          ),
        );
      case 'messenger':
        return _verifyMessengerUsecase.execute(
          VerifyBotMessengerIntegrationUsecaseInput(
            botToken: values['Bot Token'] ?? '',
            pageId: values['Bot Page ID'] ?? '',
            appSecret: values['Bot App Secret'] ?? '',
          ),
        );
      default:
        throw Exception('Unknown platform type');
    }
  }

  Future<bool> disconnectBot() async {
    inputIsLoading.add(true);
    try {
      if (platform == null) {
        inputIsLoading.add(false);
        return false;
      }

      final result = await _disconnectBotIntegrationUsecase.execute(DisconnectBotIntegrationUsecaseInput(assistandId: platform!.assistantId, type: platform!.type));
      return result.fold(
        (failure) {
          inputError.add(failure.message);
          return false;
        },
        (_) => true,
      );
    } catch (e) {
      inputError.add(e.toString());
      return false;
    } finally {
      inputIsLoading.add(false);
    }
  }

  @override
  void dispose() {
    _errorController.close();
    _isLoadingController.close();
    super.dispose();
  }

  @override
  Sink<String> get inputError => _errorController.sink;
  @override
  Sink<bool> get inputIsLoading => _isLoadingController.sink;

  @override
  Stream<String> get outputError => _errorController.stream;
  @override
  Stream<bool> get outputIsLoading => _isLoadingController.stream;

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

abstract class ConfigureViewModelInputs {
  Sink<String> get inputError;
  Sink<bool> get inputIsLoading;
}

abstract class ConfigureViewModelOutputs {
  Stream<String> get outputError;
  Stream<bool> get outputIsLoading;
}
