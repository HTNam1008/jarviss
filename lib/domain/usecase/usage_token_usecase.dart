
import 'package:dartz/dartz.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class UsageTokenUseCase implements BaseUseCase<NoParams ,TokenUsage> {
  final Repository _repository;

  UsageTokenUseCase(this._repository);

  @override
  Future<Either<Failure, TokenUsage>> execute(NoParams params) async {
    return await _repository.getTokenUsage();
  }
}

