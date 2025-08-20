// lib/data/models/task.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'task.freezed.dart';
part 'task.g.dart';

enum TaskInterval { none, daily, weekly, monthly, quarterly, yearly }

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    String? description,
    String? roomId,
    String? projectId,
    required DateTime createdAt,
    DateTime? dueAt,
    DateTime? completedAt,
    @Default(false) bool important,
    @Default(TaskInterval.none) TaskInterval interval,
    @Default([]) List<String> assigneeProfileIds,
    @Default(0) int points,
    @Default(false) bool rotated, // for rotation schedules
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
