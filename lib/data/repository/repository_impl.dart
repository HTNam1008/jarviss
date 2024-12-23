import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jarvis/data/data_source/remote_data_source.dart';
import 'package:jarvis/data/mapper/mapper.dart';
import 'package:jarvis/data/network/error_handler.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/network/network_info.dart';
import 'package:jarvis/data/request/ai_bot/get_assistants_request.dart';
import 'package:jarvis/data/request/ai_chat/conversation/conversation_history_request.dart';
import 'package:jarvis/data/request/ai_chat/conversation/conversations_request.dart';
import 'package:jarvis/data/request/ai_chat/send_message/send_message_request.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/data/responses/authentication_kb/knowledge_auth_response.dart';
import '../../../app/constant.dart';


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
  Future<Either<Failure, GetAssistantsResponse>> getAssistants(GetAssistantsRequest getAssistantsRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getAssistants(getAssistantsRequest);
        print("response: $response");
        return Right(response);
        // return Right(response.toDomain());
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
}
