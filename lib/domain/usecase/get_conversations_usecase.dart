import 'package:dartz/dartz.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/app/functions.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_chat/conversation/conversations_request.dart';
import 'package:jarvis/data/request/ai_chat/send_message/assistant.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class GetConversationsUsecase
    implements BaseUseCase<GetConversationsUsecaseInput, Conversations> {
  final Repository _repository;

  GetConversationsUsecase(this._repository);

  @override
  Future<Either<Failure, Conversations>> execute(
      GetConversationsUsecaseInput input) async {
    String? assistantId;
    String? assistantModel;
    if (input.assistant != null) {
      assistantId = input.assistant!.id;
      assistantModel = input.assistant!.model;
    }

    final Either<Failure, Conversations> result;

    if (input.cursor != null) {
      result = await _repository.getConversations(ConversationsRequest(
        cursor: input.cursor,
        assistandId: assistantId ?? getModelId(ConstantAssistantID.GPT_4_O_MINI),
        assistantModel: assistantModel ?? ConstantAssistantModel.DIFY));
    } else {
      result = await _repository.getConversations(ConversationsRequest(
        assistandId: assistantId ?? getModelId(ConstantAssistantID.GPT_4_O_MINI),
        assistantModel: assistantModel ?? ConstantAssistantModel.DIFY));
    }

    return result;
  }
}

class GetConversationsUsecaseInput {
  final Assistant? assistant;
  final String? cursor;

  GetConversationsUsecaseInput({this.assistant, this.cursor});
}
