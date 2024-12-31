// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/bot_integration/publish_slack_bot_request.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class PublishSlackBotIntegrationUsecase implements BaseUseCase<PublishBotSlackIntegrationUsecaseInput, void> {
  final Repository _repository;

  PublishSlackBotIntegrationUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(PublishBotSlackIntegrationUsecaseInput input) async {
    return await _repository.publishBotSlackIntegration(
      PublishSlackBotRequest(
        assistandId: input.assistandId,
        botToken: input.botToken,
        clientId: input.clientId, 
        clientSecret: input.clientSecret, 
        signingSecret: input.signingSecret),
    );
  }
}

class PublishBotSlackIntegrationUsecaseInput {
  final String assistandId;
  final String botToken;
  final String clientId;
  final String clientSecret;
  final String signingSecret;

  PublishBotSlackIntegrationUsecaseInput({
    required this.assistandId,
    required this.botToken,
    required this.clientId,
    required this.clientSecret,
    required this.signingSecret,
  });
}
