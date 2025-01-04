import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/data/request/email/create_response_email_request.dart';
import 'package:jarvis/data/responses/email/create_email_reply_response.dart';
import 'package:jarvis/data/responses/email/create_response_email_response.dart';
import 'package:jarvis/domain/model/prompt.dart';
import 'package:jarvis/domain/repository/prompt_repository.dart';
import 'package:jarvis/domain/repository/repository.dart';

import 'base_usecase.dart';

class CreateResponseEmailUsecase implements BaseUseCase<CreateResponseEmailParams, CreateResponseEmailResponse> {
  final Repository _repository;

  CreateResponseEmailUsecase(this._repository);

  @override
  Future<Either<Failure, CreateResponseEmailResponse>> execute(CreateResponseEmailParams input) async {
    final style = EmailStyle(
        length: input.length,
        tone: input.tone,
        formality: input.formality
    );
    final metaData = Metadata(
        context: [],
        subject: input.subject,
        sender: input.sender,
        style: style,
        receiver: input.receiver,
        language: input.language
    );
    final request = CreaterResponseEmailRequest(
        mainIdea: input.mainIdea,
        action: input.action,
        email: input.email,
        metadata: metaData
    );
    return await _repository.createResponseEmail(request);
  }
}

class CreateResponseEmailParams {
  final String mainIdea;
  final String action;
  final String email;
  final String subject;
  final String sender;
  final String receiver;
  final String language;
  final String length;
  final String tone;
  final String formality;

  CreateResponseEmailParams({
    required this.mainIdea,
    required this.action,
    required this.email,
    required this.subject,
    required this.sender,
    required this.receiver,
    required this.language,
    required this.length,
    required this.tone,
    required this.formality
  });
}

