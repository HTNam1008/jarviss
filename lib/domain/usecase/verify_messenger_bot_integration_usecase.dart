// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/bot_integration/verify_messenger_bot_integration_request.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class VerifyMessengerBotIntegrationUsecase implements BaseUseCase<VerifyBotMessengerIntegrationUsecaseInput, void> {
  final Repository _repository;

  VerifyMessengerBotIntegrationUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(VerifyBotMessengerIntegrationUsecaseInput input) async {
    return await _repository.verifyBotMessengerIntegration(
      VerifyMessengerBotIntegrationRequest(
        appSecret: input.appSecret,
        botToken: input.botToken,
        pageId: input.pageId,
      ),
    );
  }
}

class VerifyBotMessengerIntegrationUsecaseInput {
  final String appSecret;
  final String botToken;
  final String pageId;

  VerifyBotMessengerIntegrationUsecaseInput({
    required this.appSecret,
    required this.botToken,
    required this.pageId,
  });
}
