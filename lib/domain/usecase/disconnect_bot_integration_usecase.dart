// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/bot_integration/disconnect_bot_integration_request.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class DisconnectBotIntegrationUsecase implements BaseUseCase<DisconnectBotIntegrationUsecaseInput, void> {
  final Repository _repository;

  DisconnectBotIntegrationUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(DisconnectBotIntegrationUsecaseInput input) async {
    return await _repository.disconnectBotIntegration(
      DisconnectBotIntegrationRequest(
        assistantId: input.assistandId, 
        type: input.type
      ),
    );
  }
}

class DisconnectBotIntegrationUsecaseInput {
  final String assistandId;
  final String type;

  DisconnectBotIntegrationUsecaseInput({
    required this.assistandId,
    required this.type,
  });
}
