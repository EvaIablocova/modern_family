// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  roomId: json['roomId'] as String?,
  projectId: json['projectId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  dueAt: json['dueAt'] == null ? null : DateTime.parse(json['dueAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  important: json['important'] as bool? ?? false,
  interval:
      $enumDecodeNullable(_$TaskIntervalEnumMap, json['interval']) ??
      TaskInterval.none,
  assigneeProfileIds:
      (json['assigneeProfileIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  points: (json['points'] as num?)?.toInt() ?? 0,
  rotated: json['rotated'] as bool? ?? false,
);

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'roomId': instance.roomId,
      'projectId': instance.projectId,
      'createdAt': instance.createdAt.toIso8601String(),
      'dueAt': instance.dueAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'important': instance.important,
      'interval': _$TaskIntervalEnumMap[instance.interval]!,
      'assigneeProfileIds': instance.assigneeProfileIds,
      'points': instance.points,
      'rotated': instance.rotated,
    };

const _$TaskIntervalEnumMap = {
  TaskInterval.none: 'none',
  TaskInterval.daily: 'daily',
  TaskInterval.weekly: 'weekly',
  TaskInterval.monthly: 'monthly',
  TaskInterval.quarterly: 'quarterly',
  TaskInterval.yearly: 'yearly',
};
