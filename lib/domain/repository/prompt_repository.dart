import 'package:dartz/dartz.dart';
import '../../data/request/request.dart';
import '../model/prompt.dart';
import '../../data/network/failure.dart';

abstract class PromptRepository {
  Future<Either<Failure, List<Prompt>>> getPublicPrompts(String category,  {bool? isFavorite, String? query});
  Future<Either<Failure, List<Prompt>>> getPrivatePrompts(String category, {bool? isFavorite, String? query});
  Future<Either<Failure, void>> addToFavorites(String promptId);
  Future<Either<Failure, Prompt>> createPrompt(CreatePromptRequest request);
  Future<Either<Failure, void>> updatePrompt(String promptId, UpdatePromptRequest request);
  Future<Either<Failure, void>> deletePrompt(String promptId);
}
