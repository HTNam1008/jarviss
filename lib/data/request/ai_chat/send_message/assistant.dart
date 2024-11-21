
import 'package:json_annotation/json_annotation.dart';

part 'assistant.g.dart';

@JsonSerializable()
class Assistant {
  final String? id;
  final String model;
  final String name;

  Assistant({
    this.id,
    required this.model,
    required this.name,
  });

  factory Assistant.fromJson(Map<String, dynamic> json) =>
      _$AssistantFromJson(json);

  Map<String, dynamic> toJson() => _$AssistantToJson(this);
}
