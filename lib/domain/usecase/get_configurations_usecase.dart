import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/bot_integration/get_configurations_request.dart';
import 'package:jarvis/data/responses/bot_integration/get_configurations_response.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class GetConfigurationsUseCase implements BaseUseCase<GetConfigurationsUseCaseInput, List<Configuration>> {
  final Repository _repository;

  GetConfigurationsUseCase(this._repository);

  @override
  Future<Either<Failure, List<Configuration>>> execute(GetConfigurationsUseCaseInput input) async {
    return await _repository.getConfigurations(
      GetConfigurationsRequest(
        assistantId: input.assistantId,
      ),
    );
  }
}

class GetConfigurationsUseCaseInput {
  final String assistantId;

  GetConfigurationsUseCaseInput({required this.assistantId});
}