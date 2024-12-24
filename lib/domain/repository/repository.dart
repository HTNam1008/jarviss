import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/ask_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/create_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/create_thread_request.dart';
import 'package:jarvis/data/request/ai_bot/delete_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/get_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/get_assistants_request.dart';
import 'package:jarvis/data/request/ai_bot/retrieve_message_thread_request.dart';
import 'package:jarvis/data/request/ai_bot/update_assistant_new_thread_playground_request.dart';
import 'package:jarvis/data/request/ai_bot/update_assistant_request.dart';
import 'package:jarvis/data/request/ai_chat/conversation/conversation_history_request.dart';
import 'package:jarvis/data/request/ai_chat/conversation/conversations_request.dart';
import 'package:jarvis/data/request/ai_chat/send_message/send_message_request.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/data/request/authentication/request.dart';

abstract class Repository {
  Future<Either<Failure, Token>> signIn(SignInRequest signInRequest);
  Future<Either<Failure, User>> signUp(SignUpRequest signUpRequest);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, Token>> refreshToken(String refreshTokenRequest);
  Future<Either<Failure, Message>> sendMessage(SendMessageRequest sendMessageRequest);
  Future<Either<Failure, TokenUsage>> getTokenUsage();
  Future<Either<Failure, Conversations>> getConversations(ConversationsRequest conversationsRequest);
  Future<Either<Failure, ConversationHistory>> getConversationHistory(ConversationHistoryRequest conversationsRequest);
  Future<Either<Failure, Token>> signInKnowledgeBase(KnowledgeAuthRequest signInKbRequest);
  Future<Either<Failure, Assistants>> getAssistants(GetAssistantsRequest getAssistantsRequest);
  Future<Either<Failure, AssistantCustom>> getAssistant(GetAssistantRequest getAssistantRequest);
  Future<Either<Failure, AssistantCustom>> createAssistant(CreateAssistantRequest createAssistantRequest);
  Future<Either<Failure, AssistantCustom>> updateAssistant(UpdateAssistantRequest updateAssistantRequest);
  Future<Either<Failure, AssistantCustom>> updateAssistantNewThreadPlayGround(UpdateAssistantNewThreadPlayGroundRequest updateAssistantNewThreadPlayGroundRequest);
  Future<Either<Failure, void>> deleteAssistant(DeleteAssistantRequest deleteAssistantRequest);
  Future<Either<Failure, MessageAssistant>> askAssistant(AskAssistantRequest askAssistantRequest);
  Future<Either<Failure, MessageAssistants>> retrieveMessageThread(RetrieveMessageThreadRequest retrieveMessageThreadRequest);
  Future<Either<Failure, Thread>> createThread(CreateThreadRequest createThreadRequest);

}
