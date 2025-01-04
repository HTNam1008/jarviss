import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/data/responses/authentication_kb/knowledge_auth_response.dart';
import 'package:jarvis/domain/model/prompt.dart';
import 'package:jarvis/domain/repository/repository.dart';

import '../../data/request/knowledge/upload_slack_file_request.dart';
import '../../data/responses/knowledge/unit_response.dart';
import 'base_usecase.dart';

class UploadSlackFileUsecase implements BaseUseCase<UploadSlackFileParams, UnitResponse> {
  final Repository _repository;

  UploadSlackFileUsecase(this._repository);

  @override
  Future<Either<Failure, UnitResponse>> execute(UploadSlackFileParams) async {
    return _repository.uploadSlackFile(UploadSlackFileParams.id, UploadSlackFileParams.request);
  }
}

class UploadSlackFileParams {
  final String id;
  final UploadSlackFileRequest request;

  UploadSlackFileParams({
    required this.id,
    required this.request
  });
}