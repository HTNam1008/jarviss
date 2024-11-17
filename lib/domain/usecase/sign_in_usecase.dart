import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class SignInUseCase implements BaseUseCase<SignInUseCaseInput, Token> {
  final Repository _repository;

  SignInUseCase(this._repository);

  @override
  Future<Either<Failure, Token>> execute(SignInUseCaseInput input) async {
    return await _repository.signIn(
      SignInRequest(
        email: input.email,
        password: input.password,
      ),
    );
  }
}

class SignInUseCaseInput {
  final String email;
  final String password;

  SignInUseCaseInput(this.email, this.password);
}
