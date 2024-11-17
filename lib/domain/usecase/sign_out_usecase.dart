
import 'package:dartz/dartz.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class SignOutUseCase implements BaseUseCase<SignOutUseCaseInput, void> {
  final Repository _repository;

  SignOutUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(SignOutUseCaseInput input) async {
    return await _repository.signOut();
  }
}

class SignOutUseCaseInput {
  SignOutUseCaseInput();
}
