import 'package:json_annotation/json_annotation.dart';

enum MessageRole {
  @JsonValue('user')
  user,
  
  @JsonValue('model')
  model,
}