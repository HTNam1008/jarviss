// lib/domain/usecase/refresh_token_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class RefreshTokenUseCase implements BaseUseCase<RefreshTokenUseCaseInput, Token>{
  final Repository _repository;

  RefreshTokenUseCase(this._repository);

  @override
  Future<Either<Failure, Token>> execute(RefreshTokenUseCaseInput input) async {
    return await _repository.refreshToken(RefreshTokenRequest(refreshToken: input.refreshToken));
  }
}

class RefreshTokenUseCaseInput {
  final String refreshToken;

  RefreshTokenUseCaseInput({required this.refreshToken});
}
