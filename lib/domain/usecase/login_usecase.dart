import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Token> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Token>> execute(LoginUseCaseInput input) async {
    return await _repository.signIn(
      SignInRequest(
        email: input.email,
        password: input.password,
      ),
    );
  }
}

class LoginUseCaseInput {
  final String email;
  final String password;

  LoginUseCaseInput(this.email, this.password);
}
