import 'package:dartz/dartz.dart';
import 'package:jarvis/data/data_source/remote_data_source.dart';
import 'package:jarvis/data/mapper/mapper.dart';
import 'package:jarvis/data/network/error_handler.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/network/network_info.dart';
import 'package:jarvis/data/request/request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Token>> signIn(SignInRequest signInRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.signIn(signInRequest);

        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signUp(SignUpRequest signUpRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.signUp(signUpRequest);

        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
