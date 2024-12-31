import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class SignInKbUseCase implements BaseUseCase<SignInKbUseCaseInput, Token> {
  final Repository _repository;

  SignInKbUseCase(this._repository);

  @override
  Future<Either<Failure, Token>> execute(SignInKbUseCaseInput input) async {
    return await _repository.signInKnowledgeBase(KnowledgeAuthRequest(
      token: input.token,
    ));
  }
}

class SignInKbUseCaseInput {
  final String token;
  SignInKbUseCaseInput(this.token);
}