import 'package:dartz/dartz.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/get_assistants_request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class GetAssistantsUseCase implements BaseUseCase<GetAssistantsUseCaseInput, Assistants> {
  final Repository _repository;

  GetAssistantsUseCase(this._repository);

  @override
  Future<Either<Failure, Assistants>> execute(GetAssistantsUseCaseInput input) async {
    return await _repository.getAssistants(
      GetAssistantsRequest(
        isFavorite: input.isFavorite,
        isPublished: input.isPublished,
        limit: input.limit,
        offset: input.offset,
        order: input.order,
        orderField: input.orderField,
        q: input.q,
      ),
    );
  }
}

class GetAssistantsUseCaseInput {
  final bool? isFavorite;
  final bool? isPublished;
  final double? limit;
  final double? offset;
  final EnumOrder? order;
  final String? orderField;
  final String? q;

  GetAssistantsUseCaseInput({
    this.isFavorite,
    this.isPublished,
    this.limit,
    this.offset,
    this.order,
    this.orderField,
    this.q,
  });
}