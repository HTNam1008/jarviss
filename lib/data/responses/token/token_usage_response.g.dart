// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_usage_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenUsageResponse _$TokenUsageResponseFromJson(Map<String, dynamic> json) =>
    TokenUsageResponse(
      availableTokens: (json['availableTokens'] as num).toInt(),
      totalTokens: (json['totalTokens'] as num).toInt(),
      unlimited: json['unlimited'] as bool,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$TokenUsageResponseToJson(TokenUsageResponse instance) =>
    <String, dynamic>{
      'availableTokens': instance.availableTokens,
      'totalTokens': instance.totalTokens,
      'unlimited': instance.unlimited,
      'date': instance.date.toIso8601String(),
    };
