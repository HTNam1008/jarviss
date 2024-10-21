import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/data_source/remote_data_source.dart';
import 'package:flutter_application_1/data/mapper/mapper.dart';
import 'package:flutter_application_1/data/network/error_handler.dart';
import 'package:flutter_application_1/data/network/failure.dart';
import 'package:flutter_application_1/data/network/network_info.dart';
import 'package:flutter_application_1/data/request/request.dart';
import 'package:flutter_application_1/domain/model/model.dart';
import 'package:flutter_application_1/domain/repository/repository.dart';

class RepositoryImpl implements  Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // return data (success)
          // return right
          return Right(response.toDomain());
        } else {
          // return business logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
