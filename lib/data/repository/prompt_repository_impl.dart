import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:jarvis/data/mapper/prompt_mapper.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';
import '../../domain/model/prompt.dart';
import '../../domain/repository/prompt_repository.dart';
import '../request/request.dart';

class PromptRepositoryImpl implements PromptRepository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  PromptRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<Prompt>>> getPublicPrompts(String category, {bool? isFavorite, String? query,int? limit}) async {
    if (await _networkInfo.isConnected) {
      try {
        String? category1 = isFavorite!= null ? null : 'business';
        category1 = query!= null ? null : 'business';
        final categoryParam = category.toLowerCase() == "all" ? category1 : category.toLowerCase();
        final response = await _remoteDataSource.getPrompts(
          categoryParam,
          true,
          isFavorite: isFavorite,
          query: query,
          limit: limit,
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
  Future<Either<Failure, List<Prompt>>> getPrivatePrompts(String category, {bool? isFavorite, String? query}) async {
    if (await _networkInfo.isConnected) {
      try {
        // Only pass category if it's not "all"
        final categoryParam = category.toLowerCase() == "all" ? null : category.toLowerCase();

        final response = await _remoteDataSource.getPrompts(
          categoryParam,
          false,
          isFavorite: isFavorite,
          query: query,
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

  Future<Either<Failure, Prompt>> createPrompt(CreatePromptRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.createPrompt(request);
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  @override
  Future<Either<Failure, void>> updatePrompt(String promptId, UpdatePromptRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.updatePrompt(promptId, request);
        return const Right(null);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deletePrompt(String promptId) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.deletePrompt(promptId);
        return const Right(null);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

}