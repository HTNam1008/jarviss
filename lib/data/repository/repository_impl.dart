import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jarvis/data/data_source/remote_data_source.dart';
import 'package:jarvis/data/mapper/mapper.dart';
import 'package:jarvis/data/network/error_handler.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/network/network_info.dart';
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
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/data/request/bot_integration/disconnect_bot_integration_request.dart';
import 'package:jarvis/data/request/bot_integration/get_configurations_request.dart';
import 'package:jarvis/data/request/bot_integration/publish_messenger_bot_request.dart';
import 'package:jarvis/data/request/bot_integration/publish_slack_bot_request.dart';
import 'package:jarvis/data/request/bot_integration/publish_telegram_bot_request.dart';
import 'package:jarvis/data/request/bot_integration/verify_messenger_bot_integration_request.dart';
import 'package:jarvis/data/request/bot_integration/verify_slack_bot_integration_request.dart';
import 'package:jarvis/data/request/bot_integration/verify_telegram_bot_integration_request.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/data/responses/bot_integration/get_configurations_response.dart';
import 'package:jarvis/data/responses/email/create_email_reply_response.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/data/responses/authentication_kb/knowledge_auth_response.dart';
import '../../../app/constant.dart';
import '../request/email/create_email_reply_request.dart';
import '../request/email/create_response_email_request.dart';
import '../responses/email/create_response_email_response.dart';


class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Token>> signIn(SignInRequest signInRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.signIn(signInRequest);

        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signUp(SignUpRequest signUpRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.signUp(signUpRequest);

        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.signOut();
        
        return const Right(null);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  
  @override
  Future<Either<Failure, Token>> refreshToken(String refreshTokenRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.refreshToken(refreshTokenRequest);

        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage(SendMessageRequest sendMessageRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.sendMessage(sendMessageRequest);

        return Right(response.toDomain(isUser: false));
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, TokenUsage>> getTokenUsage() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getTokenUsage();

        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Conversations>> getConversations(ConversationsRequest conversationsRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getConversations(conversationsRequest);

        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ConversationHistory>> getConversationHistory(ConversationHistoryRequest conversationHistoryRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getConversationHistory(conversationHistoryRequest);

        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Token>> signInKnowledgeBase(KnowledgeAuthRequest signInKbRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.signInKnowledgeBase(signInKbRequest);
        print("response: $response");
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Assistants>> getAssistants(GetAssistantsRequest getAssistantsRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getAssistants(getAssistantsRequest);
        print("response: $response");
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, AssistantCustom>> getAssistant(GetAssistantRequest getAssistantRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getAssistant(getAssistantRequest);
        print("response: $response");
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, AssistantCustom>> createAssistant(CreateAssistantRequest createAssistantRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.createAssistant(createAssistantRequest);
        print("response: $response");
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, AssistantCustom>> updateAssistant(UpdateAssistantRequest updateAssistantRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.updateAssistant(updateAssistantRequest);
        print("response: $response");
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteAssistant(DeleteAssistantRequest deleteAssistantRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.deleteAssistant(deleteAssistantRequest);
        return const Right(null);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, MessageAssistant>> askAssistant(AskAssistantRequest askAssistantRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.askAssistant(askAssistantRequest);
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, MessageAssistants>> retrieveMessageThread(RetrieveMessageThreadRequest retrieveMessageThreadRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.retrieveMessageThread(retrieveMessageThreadRequest);
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, AssistantCustom>> updateAssistantNewThreadPlayGround(UpdateAssistantNewThreadPlayGroundRequest updateAssistantNewThreadPlayGroundRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.updateAssistantNewThreadPlayGround(updateAssistantNewThreadPlayGroundRequest);
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Thread>> createThread(CreateThreadRequest createThreadRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.createThread(createThreadRequest);
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Configuration>>> getConfigurations(GetConfigurationsRequest getConfigurationsRequest) async {
      if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getConfigurations(getConfigurationsRequest);
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> verifyBotMessengerIntegration(VerifyMessengerBotIntegrationRequest verifyMessengerBotIntegrationRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.verifyBotMessengerIntegration(verifyMessengerBotIntegrationRequest);
        return const Right(null);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> verifyBotSlackIntegration(VerifySlackBotIntegrationRequest verifySlackBotIntegrationRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.verifyBotSlackIntegration(verifySlackBotIntegrationRequest);
        return const Right(null);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> verifyBotTelegramIntegration(VerifyTelegramBotIntegrationRequest verifyTelegramBotIntegrationRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.verifyBotTelegramIntegration(verifyTelegramBotIntegrationRequest);
        return const Right(null);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> publishBotMessengerIntegration(PublishMessengerBotRequest publishMessengerBotRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.publishBotMessengerIntegration(publishMessengerBotRequest);
        return const Right(null);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> publishBotSlackIntegration(PublishSlackBotRequest publishSlackBotRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.publishBotSlackIntegration(publishSlackBotRequest);
        return const Right(null);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> publishBotTelegramIntegration(PublishTelegramBotRequest publishTelegramBotRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.publishBotTelegramIntegration(publishTelegramBotRequest);
        return const Right(null);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> disconnectBotIntegration(DisconnectBotIntegrationRequest disconnectBotIntegrationRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.disconnectBotIntegration(disconnectBotIntegrationRequest);
        return const Right(null);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, KnowledgeResponse>> createKnowledge(CreateKnowledgeRequest request) async {
    try {
      final response = await _remoteDataSource.createKnowledge(request);
      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, KnowledgeResponse>> updateKnowledge(String id, CreateKnowledgeRequest request) async {
    try {
      final response = await _remoteDataSource.updateKnowledge(id, request);
      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, GetKnowledgeResponse>> getKnowledge({
    int? limit,
    int? offset,
    EnumOrder? order,
    String? orderField,
    String? q,
  }) async {
    try {
      log('Fetched knowledge repositry');
      final response = await _remoteDataSource.getKnowledge(
        limit: limit,
        offset: offset,
        order: order,
        orderField: orderField,
        q: q,
      );
      print("response: $response");
      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, GetUnitsResponse>> getUnits({
    required String id,
    int? limit,
    int? offset,
    EnumOrder? order,
    String? orderField,
    String? q,
  }) async {
    try {
      log('Fetched knowledge repositry');
      final response = await _remoteDataSource.getUnits(
        id: id,
        limit: limit,
        offset: offset,
        order: order,
        orderField: orderField,
        q: q,
      );
      print("response: $response");
      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, void>> deleteKnowledge(String id) async {
    try {
      await _remoteDataSource.deleteKnowledge(id);
      return const Right(null);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, UnitResponse>> uploadLocalFile(String id, File file) async {
    try {
      final response = await  _remoteDataSource.uploadLocalFile(id, file);
      log(file.path);
      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, UnitResponse>> uploadSlackFile(String id, UploadSlackFileRequest request) async {
    try {
      final response = await _remoteDataSource.uploadSlackFile(id, request);
      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, UnitResponse>> uploadWebFile(String id, UploadWebFileRequest request) async {
    try {
      final response = await _remoteDataSource.uploadWebFile(id, request);
      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, UnitResponse>> uploadConfluenceFile(String id, UploadConfluenceFileRequest request) async {
    try {
      final response = await _remoteDataSource.uploadConfluenceFile(id, request);
      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, CreateEmailReplyResponse>> createEmailReply(CreateEmailReplyRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.createEmailReply(request);
        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, CreateResponseEmailResponse>> createResponseEmail(CreaterResponseEmailRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.createResponseEmail(request);
        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
