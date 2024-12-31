import 'package:dartz/dartz.dart';

import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/bot_integration/verify_telegram_bot_integration_request.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class VerifyTelegramBotIntegrationUsecase implements BaseUseCase<VerifyBotTelegramIntegrationUsecaseInput, void> {
  final Repository _repository;

  VerifyTelegramBotIntegrationUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(VerifyBotTelegramIntegrationUsecaseInput input) async {
    return await _repository.verifyBotTelegramIntegration(
      VerifyTelegramBotIntegrationRequest(
        botToken: input.botToken,
      ),
    );
  }
}

class VerifyBotTelegramIntegrationUsecaseInput {
  final String botToken;

  VerifyBotTelegramIntegrationUsecaseInput({
    required this.botToken,
  });
}
