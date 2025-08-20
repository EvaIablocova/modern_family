// lib/data/repositories/task_repository.dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/task.dart';
import '../sources/task_remote_source.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository(ref.watch(taskRemoteSourceProvider));
});

class TaskRepository {
  TaskRepository(this._remote);
  final TaskRemoteSource _remote;

  Future<List<Task>> getOverdue() => _remote.list(status: 'overdue');
  Future<List<Task>> getToday(DateTime forDate) => _remote.list(status: 'today', date: forDate);
  Future<List<Task>> getUpcoming() => _remote.list(status: 'upcoming');
  Future<void> complete(String id) => _remote.complete(id);

  Future<Task> create({
    required String title,
    String? description,
    DateTime? dueAt,
    bool important = false,
    TaskInterval interval = TaskInterval.none,
    int points = 5,
    List<String> assigneeProfileIds = const [],
  }) => _remote.create(
        title: title,
        description: description,
        dueAt: dueAt,
        important: important,
        interval: interval,
        points: points,
        assigneeProfileIds: assigneeProfileIds,
      );
}
