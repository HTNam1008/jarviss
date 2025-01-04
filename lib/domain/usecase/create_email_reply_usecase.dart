import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/data/request/email/create_email_reply_request.dart';
import 'package:jarvis/data/responses/email/create_email_reply_response.dart';
import 'package:jarvis/domain/model/prompt.dart';
import 'package:jarvis/domain/repository/prompt_repository.dart';
import 'package:jarvis/domain/repository/repository.dart';

import 'base_usecase.dart';

class CreateEmailReplyUsecase implements BaseUseCase<CreateEmailReplyRequest, CreateEmailReplyResponse> {
  final Repository _repository;

  CreateEmailReplyUsecase(this._repository);

  @override
  Future<Either<Failure, CreateEmailReplyResponse>> execute(CreateEmailReplyRequest input) async {
    return await _repository.createEmailReply(input);
  }
}