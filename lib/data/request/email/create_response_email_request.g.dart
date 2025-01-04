// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_response_email_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreaterResponseEmailRequest _$CreaterResponseEmailRequestFromJson(
        Map<String, dynamic> json) =>
    CreaterResponseEmailRequest(
      mainIdea: json['mainIdea'] as String,
      action: json['action'] as String,
      email: json['email'] as String,
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreaterResponseEmailRequestToJson(
        CreaterResponseEmailRequest instance) =>
    <String, dynamic>{
      'mainIdea': instance.mainIdea,
      'action': instance.action,
      'email': instance.email,
      'metadata': instance.metadata,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      context:
          (json['context'] as List<dynamic>).map((e) => e as String).toList(),
      subject: json['subject'] as String,
      sender: json['sender'] as String,
      receiver: json['receiver'] as String,
      style: EmailStyle.fromJson(json['style'] as Map<String, dynamic>),
      language: json['language'] as String,
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'context': instance.context,
      'subject': instance.subject,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'style': instance.style,
      'language': instance.language,
    };

EmailStyle _$EmailStyleFromJson(Map<String, dynamic> json) => EmailStyle(
      length: json['length'] as String,
      formality: json['formality'] as String,
      tone: json['tone'] as String,
    );

Map<String, dynamic> _$EmailStyleToJson(EmailStyle instance) =>
    <String, dynamic>{
      'length': instance.length,
      'formality': instance.formality,
      'tone': instance.tone,
    };
