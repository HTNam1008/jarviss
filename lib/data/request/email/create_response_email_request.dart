import 'package:json_annotation/json_annotation.dart';

part 'create_response_email_request.g.dart'; // This will generate the necessary code.

@JsonSerializable()
class CreaterResponseEmailRequest {
  final String mainIdea;
  final String action;
  final String email;
  final Metadata metadata;

  CreaterResponseEmailRequest({
    required this.mainIdea,
    required this.action,
    required this.email,
    required this.metadata,
  });

  // Factory constructor for creating a new `CreateEmailRequest` instance from JSON data
  factory CreaterResponseEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$CreaterResponseEmailRequestFromJson(json);

  // `toJson` method for converting an instance of `CreateEmailRequest` into JSON format
  Map<String, dynamic> toJson() => _$CreaterResponseEmailRequestToJson(this);
}

@JsonSerializable()
class Metadata {
  final List<String> context;
  final String subject;
  final String sender;
  final String receiver;
  final EmailStyle style;
  final String language;

  Metadata({
    required this.context,
    required this.subject,
    required this.sender,
    required this.receiver,
    required this.style,
    required this.language,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonSerializable()
class EmailStyle {
  final String length;
  final String formality;
  final String tone;

  EmailStyle({
    required this.length,
    required this.formality,
    required this.tone,
  });

  factory EmailStyle.fromJson(Map<String, dynamic> json) =>
      _$EmailStyleFromJson(json);

  Map<String, dynamic> toJson() => _$EmailStyleToJson(this);
}
