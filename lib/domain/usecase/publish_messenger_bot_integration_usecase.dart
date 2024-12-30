// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/bot_integration/publish_messenger_bot_request.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class PublishMessengerBotIntegrationUsecase implements BaseUseCase<PublishBotMessengerIntegrationUsecaseInput, void> {
  final Repository _repository;

  PublishMessengerBotIntegrationUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(PublishBotMessengerIntegrationUsecaseInput input) async {
    return await _repository.publishBotMessengerIntegration(
      PublishMessengerBotRequest(
        appSecret: input.appSecret, 
        botToken: input.botToken, 
        pageId: input.pageId, 
        assistandId: input.assistandId,
      )
    );
  }
}

class PublishBotMessengerIntegrationUsecaseInput {
  final String assistandId;
  final String botToken;
  final String appSecret;
  final String pageId;

  PublishBotMessengerIntegrationUsecaseInput({
    required this.assistandId,
    required this.botToken,
    required this.appSecret,
    required this.pageId,
  });
}
