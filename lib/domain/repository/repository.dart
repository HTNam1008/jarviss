import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/get_assistants_request.dart';
import 'package:jarvis/data/request/ai_chat/conversation/conversation_history_request.dart';
import 'package:jarvis/data/request/ai_chat/conversation/conversations_request.dart';
import 'package:jarvis/data/request/ai_chat/send_message/send_message_request.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/data/responses/authentication_kb/knowledge_auth_response.dart';
import '../../../app/constant.dart';


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
  Future<Either<Failure, GetAssistantsResponse>> getAssistants(GetAssistantsRequest getAssistantsRequest);
  Future<Either<Failure, KnowledgeResponse>> createKnowledge(CreateKnowledgeRequest request);
  Future<Either<Failure, KnowledgeResponse>> updateKnowledge(String id, CreateKnowledgeRequest request);
  Future<Either<Failure, GetKnowledgeResponse>> getKnowledge({
    int? limit,
    int? offset,
    EnumOrder? order,
    String? orderField,
    String? q,
  });
  Future<Either<Failure, void>> deleteKnowledge(String id);
  Future<Either<Failure, UnitResponse>> uploadLocalFile(String knowledgeId, File file);
  Future<Either<Failure, UnitResponse>> uploadSlackFile(String id, UploadSlackFileRequest request);
  Future<Either<Failure, UnitResponse>> uploadWebFile(String id, UploadWebFileRequest request);
  Future<Either<Failure, UnitResponse>> uploadConfluenceFile(String id, UploadConfluenceFileRequest request);

}
