// lib/state/task_providers.dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../data/models/task.dart';
import '../data/repositories/task_repository.dart';
import '../features/tasks/presentation/widgets/task_card.dart';

final selectedDateProvider = StateProvider<DateTime>((_) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

final overdueTasksProvider = FutureProvider<List<TaskViewModel>>((ref) async {
  final repo = ref.watch(taskRepositoryProvider);
  final tasks = await repo.getOverdue();
  return _toVm(tasks);
});

final todayTasksProvider = FutureProvider<List<TaskViewModel>>((ref) async {
  final repo = ref.watch(taskRepositoryProvider);
  final selected = ref.watch(selectedDateProvider);
  final tasks = await repo.getToday(selected);
  return _toVm(tasks);
});

final upcomingTasksProvider = FutureProvider<List<TaskViewModel>>((ref) async {
  final repo = ref.watch(taskRepositoryProvider);
  final tasks = await repo.getUpcoming();
  return _toVm(tasks);
});

final taskActionsProvider = Provider<TaskActions>((ref) => TaskActions(ref));

class TaskActions {
  const TaskActions(this.ref);
  final Ref ref;

  Future<void> quickComplete(String taskId) async {
    await ref.read(taskRepositoryProvider).complete(taskId);
    ref.invalidate(overdueTasksProvider);
    ref.invalidate(todayTasksProvider);
    ref.invalidate(upcomingTasksProvider);
  }

  Future<void> createTask({
    required String title,
    String? description,
    DateTime? dueAt,
    bool important = false,
    TaskInterval interval = TaskInterval.none,
    int points = 5,
    List<String> assigneeProfileIds = const [],
  }) async {
    await ref.read(taskRepositoryProvider).create(
          title: title,
          description: description,
          dueAt: dueAt,
          important: important,
          interval: interval,
          points: points,
          assigneeProfileIds: assigneeProfileIds,
        );
    ref.invalidate(overdueTasksProvider);
    ref.invalidate(todayTasksProvider);
    ref.invalidate(upcomingTasksProvider);
  }
}

List<TaskViewModel> _toVm(List<Task> tasks) {
  // Placeholder mapping; in real code join with rooms/profiles.
  return tasks
      .map((t) => TaskViewModel(t, roomName: t.roomId, assignees: '${t.assigneeProfileIds.length} assignees'))
      .toList();
}
