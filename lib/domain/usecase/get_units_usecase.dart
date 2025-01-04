import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

import '../../data/responses/knowledge/get_units_response.dart';

class GetUnitsUsecase implements BaseUseCase<GetUnitsUseCaseInput, GetUnitsResponse> {
  final Repository _repository;

  GetUnitsUsecase(this._repository);

  @override
  Future<Either<Failure, GetUnitsResponse>> execute(GetUnitsUseCaseInput input) async {
    log('Fetched knowledge usecase');

    return await _repository.getUnits(
         id: input.id,
        limit: input.limit,
        offset: input.offset,
        order: input.order,
        orderField: input.orderField,
        q: input.q,
    );
  }
}

class GetUnitsUseCaseInput {
  final String id;
  final int? limit;
  final int? offset;
  final EnumOrder? order;
  final String? orderField;
  final String? q;

  GetUnitsUseCaseInput({
    required this.id,
    this.limit,
    this.offset,
    this.order,
    this.orderField,
    this.q,
  });
}