import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

enum TaskInterval { none, daily, weekly, monthly, quarterly, yearly }
enum TaskImportance { low, medium, high }
enum TaskStatus { pending, inProgress, completed, cancelled }

@freezed
class Task with _$Task {
  factory Task({
    @JsonKey(fromJson: _idFromJson) required String id,
    required String title,
    String? description,

    // Backend fields
    @JsonKey(name: 'dueDate', fromJson: _dateTimeFromJson) DateTime? dueAt,
    @JsonKey(fromJson: _intNullableFromJson) int? timeEstimated,
    String? recurrenceRule,
    String? importance, // maps to Task.Importance.name()
    String? status,     // maps to Task.Status.name()
    String? notes,
    String? attachments,
    String? photoBefore,
    String? photoAfter,

    @JsonKey(fromJson: _dateTimeFromJson) DateTime? createdAt,
    @JsonKey(fromJson: _dateTimeFromJson) DateTime? updatedAt,

    @Default(false) bool completed,
    @JsonKey(fromJson: _intNullableFromJson) int? timeReal,
    @JsonKey(fromJson: _intNullableFromJson) int? effort,

    @JsonKey(fromJson: _idFromJson) String? assignedToId,
    @JsonKey(fromJson: _idFromJson) String? projectId,

    // Extra frontend-only fields
    @JsonKey(fromJson: _dateTimeFromJson) DateTime? completedAt,
    @JsonKey(fromJson: _intervalFromJson, toJson: _intervalToJson)
    @Default(TaskInterval.none)
    TaskInterval interval,
    @JsonKey(fromJson: _assigneeListFromJson)
    @Default(<String>[])
    List<String> assigneeProfileIds,
    @JsonKey(fromJson: _intFromJson) @Default(0) int points,
    @Default(false) bool rotated,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

/* Helpers */

String _idFromJson(dynamic v) {
  if (v == null) return '';
  if (v is String) return v;
  if (v is num) return v.toString();
  if (v is Map && v.containsKey('id')) return _idFromJson(v['id']);
  return v.toString();
}

DateTime? _dateTimeFromJson(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  if (v is String) {
    try {
      return DateTime.parse(v);
    } catch (_) {
      final n = int.tryParse(v);
      if (n != null) return _dateTimeFromEpoch(n);
      return null;
    }
  }
  if (v is int) return _dateTimeFromEpoch(v);
  if (v is double) return _dateTimeFromEpoch(v.toInt());
  return null;
}

DateTime _dateTimeFromEpoch(int epoch) {
  if (epoch > 1000000000000) {
    return DateTime.fromMillisecondsSinceEpoch(epoch);
  }
  return DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
}

int _intFromJson(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v) ?? 0;
  return 0;
}

int? _intNullableFromJson(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v);
  return null;
}

TaskInterval _intervalFromJson(dynamic v) {
  if (v == null) return TaskInterval.none;
  if (v is TaskInterval) return v;
  if (v is int) {
    final idx = v;
    if (idx >= 0 && idx < TaskInterval.values.length) {
      return TaskInterval.values[idx];
    }
  }
  final s = v.toString().toLowerCase();
  if (s.contains('daily') || s == '1') return TaskInterval.daily;
  if (s.contains('weekly') || s == '2') return TaskInterval.weekly;
  if (s.contains('month') || s == '3') return TaskInterval.monthly;
  if (s.contains('quarter') || s == '4') return TaskInterval.quarterly;
  if (s.contains('year') || s == '5') return TaskInterval.yearly;
  return TaskInterval.none;
}

String _intervalToJson(TaskInterval i) => i.name;

List<String> _assigneeListFromJson(dynamic v) {
  if (v == null) return <String>[];
  if (v is List) {
    return v.map((e) {
      if (e == null) return '';
      if (e is String) return e;
      if (e is num) return e.toString();
      if (e is Map) {
        if (e.containsKey('id')) return _idFromJson(e['id']);
        if (e.containsKey('assignedToId')) return _idFromJson(e['assignedToId']);
      }
      return e.toString();
    }).where((s) => s.isNotEmpty).toList();
  }
  if (v is Map) {
    if (v.containsKey('id')) return [_idFromJson(v['id'])];
    return [v.toString()];
  }
  return [v.toString()];
}
