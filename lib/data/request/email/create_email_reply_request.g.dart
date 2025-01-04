// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_email_reply_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEmailReplyRequest _$CreateEmailReplyRequestFromJson(
        Map<String, dynamic> json) =>
    CreateEmailReplyRequest(
      action: json['action'] as String,
      email: json['email'] as String,
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateEmailReplyRequestToJson(
        CreateEmailReplyRequest instance) =>
    <String, dynamic>{
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
      language: json['language'] as String,
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'context': instance.context,
      'subject': instance.subject,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'language': instance.language,
    };
