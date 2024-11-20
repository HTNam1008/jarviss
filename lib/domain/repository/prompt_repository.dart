import 'package:dartz/dartz.dart';
import '../model/prompt.dart';
import '../../data/network/failure.dart';

abstract class PromptRepository {
  Future<Either<Failure, List<Prompt>>> getPublicPrompts(String category);
}