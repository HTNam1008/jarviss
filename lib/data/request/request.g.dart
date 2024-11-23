// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenRequest _$RefreshTokenRequestFromJson(Map<String, dynamic> json) =>
    RefreshTokenRequest(
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$RefreshTokenRequestToJson(
        RefreshTokenRequest instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
    };

CreatePromptRequest _$CreatePromptRequestFromJson(Map<String, dynamic> json) =>
    CreatePromptRequest(
      title: json['title'] as String,
      content: json['content'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      language: json['language'] as String,
      isPublic: json['isPublic'] as bool,
    );

Map<String, dynamic> _$CreatePromptRequestToJson(
        CreatePromptRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'description': instance.description,
      'category': instance.category,
      'language': instance.language,
      'isPublic': instance.isPublic,
    };

UpdatePromptRequest _$UpdatePromptRequestFromJson(Map<String, dynamic> json) =>
    UpdatePromptRequest(
      title: json['title'] as String?,
      content: json['content'] as String?,
      description: json['description'] as String,
      category: json['category'] as String,
      language: json['language'] as String,
      isPublic: json['isPublic'] as bool,
    );

Map<String, dynamic> _$UpdatePromptRequestToJson(
        UpdatePromptRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'description': instance.description,
      'category': instance.category,
      'language': instance.language,
      'isPublic': instance.isPublic,
    };
