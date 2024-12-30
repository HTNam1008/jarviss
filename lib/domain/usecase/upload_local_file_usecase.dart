import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/data/responses/authentication_kb/knowledge_auth_response.dart';
import 'package:jarvis/domain/model/prompt.dart';
import 'package:jarvis/domain/repository/repository.dart';

import 'base_usecase.dart';

class UploadLocalFileUsecase implements BaseUseCase<UploadLocalFileParams, UnitResponse> {
  final Repository _repository;

  UploadLocalFileUsecase(this._repository);

  @override
  Future<Either<Failure, UnitResponse>> execute(UploadLocalFileParams) async {
    return _repository.uploadLocalFile(UploadLocalFileParams.id, UploadLocalFileParams.file);
  }
}

class UploadLocalFileParams {
  final String id;
  final File file;

  UploadLocalFileParams({
    required this.id,
    required this.file,
  });
}