// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:jarvis/app/constant.dart';
import 'package:jarvis/app/extensions.dart';
import 'package:jarvis/data/responses/bot_integration/get_configurations_response.dart';
import 'package:jarvis/domain/usecase/get_configurations_usecase.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';
import 'package:jarvis/presentation/publish_bot/configure/configure_view.dart';

class Platform {
  final String name;
  bool isSelected;
  bool isVerified;
  final String assistantId;
  final dynamic metadata;

  Platform({
    required this.name,
    this.isSelected = false,
    this.isVerified = false,
    required this.assistantId,
    this.metadata,
  });

  String get type => name.toLowerCase();
}

class PublishBotViewModel extends BaseViewModel implements PublishBotViewModelInputs, PublishBotViewModelOutputs {
  final GetConfigurationsUseCase _getConfigurationsUseCase;
  final StreamController<bool> _isLoadingController = StreamController<bool>();
  final StreamController<String> _errorController = StreamController<String>();
  final StreamController<List<Platform>> _platformsController = StreamController<List<Platform>>();

  final List<Platform> _platforms = [];

  String? assistantId;

  PublishBotViewModel(this._getConfigurationsUseCase);

  Future<void> init(String assistantId) async {
    this.assistantId = assistantId;
    await getConfigurations();
  }

  Future<void> getConfigurations() async {
    if (assistantId == null) return;
    
    inputIsLoading.add(true);
    final result = await _getConfigurationsUseCase.execute(
      GetConfigurationsUseCaseInput(assistantId: assistantId!)
    );

    result.fold(
      (error) => inputError.add(error.toString()),
      (configurations) {
        _platforms.clear();

        for (var type in PlatformType.values) {
          final config = configurations.firstWhere(
            (c) => c.type == type.name.toLowerCase(), 
            orElse: () => Configuration()
          );
          
          if (config.type == null) {
            _platforms.add(Platform(
              name: type.name.capitalize(),
              metadata: null,
              isVerified: false,
              assistantId: assistantId!,
            ));
            continue;
          }

          _platforms.add(Platform(
            name: type.name.capitalize(),
            metadata: config.metadata,
            isVerified: config.metadata != null,
            assistantId: assistantId!,
          ));
        }
        inputPlatforms.add(_platforms);
      },
    );

    inputIsLoading.add(false);
  }

  @override
  void start() {
    inputPlatforms.add(_platforms);
  }

  @override
  void dispose() {
    _isLoadingController.close();
    _errorController.close();
    _platformsController.close();
    super.dispose();
  }

  void togglePlatform(Platform platform, bool value) {
    platform.isSelected = value;
    inputPlatforms.add(_platforms);
  }

  Future<void> configurePlatform(Platform platform) async {
    inputIsLoading.add(true);
    // Add API call here
    await Future.delayed(const Duration(seconds: 1));
    platform.isVerified = true;
    inputIsLoading.add(false);
    inputPlatforms.add(_platforms);
  }

  Future<bool> publishBot() async {
    inputIsLoading.add(true);

    try {
      final selectedPlatforms = _platforms.where((p) => p.isSelected).toList();
      if (selectedPlatforms.isEmpty) {
        inputError.add('Please select at least one platform');
        return false;
      }

      await Future.delayed(const Duration(seconds: 2));

      inputIsLoading.add(false);
      return true;
    } catch (e) {
      inputError.add(e.toString());
      inputIsLoading.add(false);
      return false;
    }
  }

  Future<void> navigateToConfigureView(BuildContext context, Platform platform) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfigureView(
          platform: platform,
          metadata: platform.metadata,
        ),
      ),
    );

    if (result == true) {
      platform.isVerified = true;
      inputPlatforms.add(_platforms);
    }
  }

  @override
  Sink<bool> get inputIsLoading => _isLoadingController.sink;
  @override
  Sink<String> get inputError => _errorController.sink;
  @override
  Sink<List<Platform>> get inputPlatforms => _platformsController.sink;

  @override
  Stream<bool> get outputIsLoading => _isLoadingController.stream;
  @override
  Stream<String> get outputError => _errorController.stream;
  @override
  Stream<List<Platform>> get outputPlatforms => _platformsController.stream;

  @override
  Future<void> navigateNamed(BuildContext context, String route) {
    throw UnimplementedError();
  }

  @override
  Future<void> navigateReplaceNamed(BuildContext context, String route) {
    throw UnimplementedError();
  }
}

abstract class PublishBotViewModelInputs {
  Sink<bool> get inputIsLoading;
  Sink<String> get inputError;
  Sink<List<Platform>> get inputPlatforms;
}

abstract class PublishBotViewModelOutputs {
  Stream<bool> get outputIsLoading;
  Stream<String> get outputError;
  Stream<List<Platform>> get outputPlatforms;
}
