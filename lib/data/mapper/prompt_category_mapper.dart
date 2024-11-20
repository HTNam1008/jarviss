import '../../domain/model/model.dart';
import '../responses/responses.dart';

extension PromptCategoryResponseMapper on PromptCategoryResponse {
  PromptCategoryItem toDomain() {
    return PromptCategoryItem(
        value: value != null ? PromptCategory.values.firstWhere((e) => e.toString() == value) : null,
        label: label
    );
  }
}