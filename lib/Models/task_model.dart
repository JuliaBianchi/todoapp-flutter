import 'package:json_annotation/json_annotation.dart';
part 'task_model.g.dart';


@JsonSerializable()
class TaskModel{
  final int? id;
  final String? description;
  final int? category;
  final DateTime? created_at;
  final String? deleted_at;
  final String? updated_at;
  final bool? isCompleted;


  TaskModel({
    required this.id,
    required this.description,
    required this.category,
    required this.created_at,
    required this.updated_at,
    required this.deleted_at,
    required this.isCompleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() =>  _$TaskModelToJson(this);

}