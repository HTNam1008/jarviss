// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      email: json['email'] as String,
      password: json['password'] as String,
      username: json['username'] as String,
      isActive: json['isActive'] as bool,
      usedAuthOptions: (json['usedAuthOptions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      hashedRefreshToken: json['hashedRefreshToken'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      deletedAt: json['deletedAt'] as String?,
      id: json['id'] as String,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'username': instance.username,
      'isActive': instance.isActive,
      'usedAuthOptions': instance.usedAuthOptions,
      'roles': instance.roles,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'hashedRefreshToken': instance.hashedRefreshToken,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'deletedAt': instance.deletedAt,
      'id': instance.id,
    };

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) =>
    SignUpResponse(
      user: UserResponse.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
    };

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) =>
    TokenResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) =>
    SignInResponse(
      token: TokenResponse.fromJson(json['token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignInResponseToJson(SignInResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

SignOutResponse _$SignOutResponseFromJson(Map<String, dynamic> json) =>
    SignOutResponse();

Map<String, dynamic> _$SignOutResponseToJson(SignOutResponse instance) =>
    <String, dynamic>{};

RefreshTokenResponse _$RefreshTokenResponseFromJson(
        Map<String, dynamic> json) =>
    RefreshTokenResponse(
      token: TokenResponse.fromJson(json['token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RefreshTokenResponseToJson(
        RefreshTokenResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

PromptCategoryResponse _$PromptCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    PromptCategoryResponse(
      value: json['value'] as String?,
      label: json['label'] as String,
    );

Map<String, dynamic> _$PromptCategoryResponseToJson(
        PromptCategoryResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
    };

GetPromptsResponse _$GetPromptsResponseFromJson(Map<String, dynamic> json) =>
    GetPromptsResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => PromptResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPromptsResponseToJson(GetPromptsResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

PromptResponse _$PromptResponseFromJson(Map<String, dynamic> json) =>
    PromptResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      isPublic: json['isPublic'] as bool,
      userName: json['userName'] as String,
      isFavorite: json['isFavorite'] as bool,
    );

Map<String, dynamic> _$PromptResponseToJson(PromptResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'isPublic': instance.isPublic,
      'userName': instance.userName,
      'isFavorite': instance.isFavorite,
    };
