import 'package:dartz/dartz.dart';
import 'package:jarvis/data/mapper/prompt_mapper.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';
import '../../domain/model/prompt.dart';
import '../../domain/repository/prompt_repository.dart';

class PromptRepositoryImpl implements PromptRepository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  PromptRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<Prompt>>> getPublicPrompts(String category, {bool? isFavorite}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getPrompts(
          category.toLowerCase() == "all" ? null : category.toLowerCase(),
          true,
          isFavorite: isFavorite,
        );
        return Right(response.items.map((e) => e.toDomain()).toList());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addToFavorites(String promptId) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.addToFavorites(promptId);
        return const Right(null);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}