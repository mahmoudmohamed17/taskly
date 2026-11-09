// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  creationDate: DateTime.parse(json['creationDate'] as String),
  category:
      $enumDecodeNullable(_$TaskCategoryEnumMap, json['category']) ??
      TaskCategory.other,
  attachments:
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  lastUpdateDate: json['lastUpdateDate'] == null
      ? null
      : DateTime.parse(json['lastUpdateDate'] as String),
);

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'category': _$TaskCategoryEnumMap[instance.category]!,
  'attachments': instance.attachments,
  'creationDate': instance.creationDate.toIso8601String(),
  'lastUpdateDate': instance.lastUpdateDate?.toIso8601String(),
};

const _$TaskCategoryEnumMap = {
  TaskCategory.medical: 'medical',
  TaskCategory.financial: 'financial',
  TaskCategory.family: 'family',
  TaskCategory.friends: 'friends',
  TaskCategory.personal: 'personal',
  TaskCategory.other: 'other',
};
