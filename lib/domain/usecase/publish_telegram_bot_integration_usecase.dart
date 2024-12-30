// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/bot_integration/publish_telegram_bot_request.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class PublishTelegramBotIntegrationUsecase implements BaseUseCase<PublishBotTelegramIntegrationUsecaseInput, void> {
  final Repository _repository;

  PublishTelegramBotIntegrationUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(PublishBotTelegramIntegrationUsecaseInput input) async {
    return await _repository.publishBotTelegramIntegration(
      PublishTelegramBotRequest(
        assistandId: input.assistandId,
        botToken: input.botToken,
      )
    );
  }
}

class PublishBotTelegramIntegrationUsecaseInput {
  final String assistandId;
  final String botToken;

  PublishBotTelegramIntegrationUsecaseInput({
    required this.assistandId,
    required this.botToken,
  });
}
