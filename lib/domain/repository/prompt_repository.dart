import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/domain/model/prompt.dart';

abstract class PromptRepository {
  Future<Either<Failure, List<Prompt>>> getPublicPrompts(String category,  {bool? isFavorite, String? query, int? limit});
  Future<Either<Failure, List<Prompt>>> getPrivatePrompts(String category, {bool? isFavorite, String? query});
  Future<Either<Failure, void>> addToFavorites(String promptId);
  Future<Either<Failure, Prompt>> createPrompt(CreatePromptRequest request);
  Future<Either<Failure, void>> updatePrompt(String promptId, UpdatePromptRequest request);
  Future<Either<Failure, void>> deletePrompt(String promptId);
}
