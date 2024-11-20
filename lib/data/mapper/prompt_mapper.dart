import '../../domain/model/prompt.dart';
import 'package:jarvis/app/extensions.dart';
import 'package:jarvis/data/responses/responses.dart';
import 'package:jarvis/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;

extension PromptResponseMapper on PromptResponse {
  Prompt toDomain() {
    return Prompt(
      id: id.orEmpty(),
      title: title,
        description: description ?? '',
        category: category,
        isPublic: isPublic ?? false,
        userName: userName ?? '',
        isFavorite: isFavorite ?? false,
    );
  }
}