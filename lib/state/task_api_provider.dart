import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../data/api/task_api.dart';
import '../data/models/task.dart';
import '../features/tasks/presentation/widgets/task_card.dart';

/// Fetches all tasks directly from the backend API.
final tasksApiProvider = FutureProvider<List<Task>>((ref) async {
  return await TaskApi.getAllTasks();
});

/// Maps API tasks into TaskViewModels for UI consumption.
final tasksApiVmProvider = FutureProvider<List<TaskViewModel>>((ref) async {
  final tasks = await ref.watch(tasksApiProvider.future);
  return tasks
      .map((t) => TaskViewModel(
    t,
    assignees: '${t.assigneeProfileIds.length} assignees',
  ))
      .toList();
});
