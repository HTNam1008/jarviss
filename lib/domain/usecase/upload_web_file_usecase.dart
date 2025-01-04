import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/data/responses/authentication_kb/knowledge_auth_response.dart';
import 'package:jarvis/domain/model/prompt.dart';
import 'package:jarvis/domain/repository/repository.dart';

import '../../data/request/knowledge/upload_web_file_request.dart';
import '../../data/responses/knowledge/unit_response.dart';
import 'base_usecase.dart';

class UploadWebFileUsecase implements BaseUseCase<UploadWebFileParams, UnitResponse> {
  final Repository _repository;

  UploadWebFileUsecase(this._repository);

  @override
  Future<Either<Failure, UnitResponse>> execute(UploadWebFileParams) async {
    return _repository.uploadWebFile(UploadWebFileParams.id, UploadWebFileParams.request);
  }
}

class UploadWebFileParams {
  final String id;
  final UploadWebFileRequest request;

  UploadWebFileParams({
    required this.id,
    required this.request
  });
}