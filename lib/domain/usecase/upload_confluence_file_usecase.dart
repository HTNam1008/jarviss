import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/data/responses/authentication_kb/knowledge_auth_response.dart';
import 'package:jarvis/domain/model/prompt.dart';
import 'package:jarvis/domain/repository/repository.dart';

import 'base_usecase.dart';

class UploadConfluenceFileUsecase implements BaseUseCase<UploadConfluenceFileParams, UnitResponse> {
  final Repository _repository;

  UploadConfluenceFileUsecase(this._repository);

  @override
  Future<Either<Failure, UnitResponse>> execute(UploadConfluenceFileParams) async {
    return _repository.uploadConfluenceFile(UploadConfluenceFileParams.id, UploadConfluenceFileParams.request);
  }
}

class UploadConfluenceFileParams {
  final String id;
  final UploadConfluenceFileRequest request;

  UploadConfluenceFileParams({
    required this.id,
    required this.request
  });
}