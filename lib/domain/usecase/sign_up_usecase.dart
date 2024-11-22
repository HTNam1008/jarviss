import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_chat/authentication/request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class SignUpUseCase implements BaseUseCase<SignUpUseCaseInput, User> {
  final Repository _repository;

  SignUpUseCase(this._repository);

  @override
  Future<Either<Failure, User>> execute(SignUpUseCaseInput input) async {
    return await _repository.signUp(
      SignUpRequest(
        email: input.email,
        password: input.password, 
        username: input.username,
      ),
    );
  }
}

class SignUpUseCaseInput {
  final String email;
  final String password;
  final String username;

  SignUpUseCaseInput(this.email, this.password, this.username);
}
