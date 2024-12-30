import 'package:dartz/dartz.dart';

import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/bot_integration/verify_slack_bot_integration_request.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class VerifySlackBotIntegrationUsecase implements BaseUseCase<VerifyBotSlackIntegrationUsecaseInput, void> {
  final Repository _repository;

  VerifySlackBotIntegrationUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(VerifyBotSlackIntegrationUsecaseInput input) async {
    return await _repository.verifyBotSlackIntegration(
      VerifySlackBotIntegrationRequest(
        botToken: input.botToken,
        clientId: input.clientId, 
        clientSecret: input.clientSecret, 
        signingSecret: input.signingSecret),
    );
  }
}

class VerifyBotSlackIntegrationUsecaseInput {
  final String botToken;
  final String clientId;
  final String clientSecret;
  final String signingSecret;

  VerifyBotSlackIntegrationUsecaseInput({
    required this.botToken,
    required this.clientId,
    required this.clientSecret,
    required this.signingSecret,
  });
}
