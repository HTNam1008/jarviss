// lib/domain/usecase/get_conversation_messages_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/app/functions.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_chat/conversation/conversation_history_request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class GetConversationHistoryUsecase implements BaseUseCase<GetConversationHistoryUsecaseInput, ConversationHistory> {
  final Repository _repository;

  GetConversationHistoryUsecase(this._repository);

  @override
  Future<Either<Failure, ConversationHistory>> execute(
      GetConversationHistoryUsecaseInput input) async {
    final ConversationHistoryRequest conversationHistoryRequest =
        ConversationHistoryRequest(
            conversationId: input.conversationId,
            assistandId: input.assistantId ?? getModelId(ConstantAssistantID.GPT_4_O_MINI),
            assistantModel: input.assistantModel ?? ConstantAssistantModel.DIFY,
            cursor: input.cursor
            );
    return await _repository.getConversationHistory(conversationHistoryRequest);
  }
}

class GetConversationHistoryUsecaseInput {
  final String conversationId;
  final String? assistantId;
  final String? assistantModel;
  final String? cursor;

  GetConversationHistoryUsecaseInput({
    required this.conversationId,
    this.assistantId,
    this.assistantModel,
    this.cursor,
  });
}
