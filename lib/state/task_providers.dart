import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../data/models/task.dart';
import '../data/repositories/task_repository.dart';
import '../features/tasks/presentation/widgets/task_card.dart';

/// Holds the currently selected calendar date (normalized to year/month/day).
final selectedDateProvider = StateProvider<DateTime>((_) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

/// Tasks that are overdue relative to the selected date.
final overdueTasksProvider = FutureProvider<List<TaskViewModel>>((ref) async {
  final repo = ref.watch(taskRepositoryProvider);
  final tasks = await repo.getOverdue();
  return _toVm(tasks);
});

/// Tasks due on the selected date.
final todayTasksProvider = FutureProvider<List<TaskViewModel>>((ref) async {
  final repo = ref.watch(taskRepositoryProvider);
  final selected = ref.watch(selectedDateProvider);
  final tasks = await repo.getToday(selected);
  return _toVm(tasks);
});

/// Tasks scheduled after the selected date.
final upcomingTasksProvider = FutureProvider<List<TaskViewModel>>((ref) async {
  final repo = ref.watch(taskRepositoryProvider);
  final tasks = await repo.getUpcoming();
  return _toVm(tasks);
});

/// Provides task actions (create, complete, etc.).
final taskActionsProvider = Provider<TaskActions>((ref) => TaskActions(ref));

class TaskActions {
  const TaskActions(this.ref);
  final Ref ref;

  /// Marks a task as completed quickly and refreshes providers.
  Future<void> quickComplete(String taskId) async {
    await ref.read(taskRepositoryProvider).complete(taskId);
    _refreshTaskProviders(ref);
  }

  /// Creates a new task and refreshes providers.
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
    _refreshTaskProviders(ref);
  }

  void _refreshTaskProviders(Ref ref) {
    ref.invalidate(overdueTasksProvider);
    ref.invalidate(todayTasksProvider);
    ref.invalidate(upcomingTasksProvider);
  }
}

/// Maps raw Task models into TaskViewModels for UI display.
List<TaskViewModel> _toVm(List<Task> tasks) {
  // Placeholder mapping; in real code join with rooms/profiles.
  return tasks
      .map((t) => TaskViewModel(
    t,
    assignees: '${t.assigneeProfileIds.length} assignees',
  ))
      .toList();
}
