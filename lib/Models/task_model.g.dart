// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as int,
      description: json['description'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      deleted_at: json['deleted_at'] as String,
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'created_at': instance.created_at,
      'deleted_at': instance.deleted_at,
      'updated_at': instance.updated_at,
      'isCompleted': instance.isCompleted,
    };
