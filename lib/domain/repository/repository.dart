import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_chat/conversation/conversation_history_request.dart';
import 'package:jarvis/data/request/ai_chat/conversation/conversations_request.dart';
import 'package:jarvis/data/request/ai_chat/send_message/send_message_request.dart';
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
}
