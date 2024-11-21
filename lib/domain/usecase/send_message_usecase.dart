// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_chat/send_message/assistant.dart';
import 'package:jarvis/data/request/ai_chat/send_message/send_message_metadata.dart';
import 'package:jarvis/data/request/ai_chat/send_message/send_message_request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';
import 'package:json_annotation/json_annotation.dart';
part 'send_message_usecase.g.dart';

class SendMessageUseCase implements BaseUseCase<SendMessageUseCaseInput, Message> {
  final Repository _repository;

  SendMessageUseCase(this._repository);

  @override
  Future<Either<Failure, Message>> execute(SendMessageUseCaseInput input) async {
    return await _repository.sendMessage(
      SendMessageRequest(
        assistant: input.assistant,
        content: input.content,
        files: input.files,
        metadata: input.metadata
      ),
    );
  }
}


@JsonSerializable()
class SendMessageUseCaseInput {
  final Assistant? assistant;
  final String content;
  final List<String>? files;
  final SendMessageMetadata? metadata;

  SendMessageUseCaseInput({
    this.assistant,
    required this.content,
    this.files,
    this.metadata,
  });

  factory SendMessageUseCaseInput.fromJson(Map<String, dynamic> json) =>
      _$SendMessageUseCaseInputFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageUseCaseInputToJson(this);
}
