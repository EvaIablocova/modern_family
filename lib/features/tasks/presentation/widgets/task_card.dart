import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../data/models/task.dart';
import '../../../../state/task_providers.dart';

class TaskViewModel {
  TaskViewModel(this.task, {required this.assignees});
  final Task task;
  final String assignees;
}

class TaskCard extends ConsumerWidget {
  const TaskCard({super.key, required this.vm});
  final TaskViewModel vm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = vm.task;

    // Map importance string to icon
    final isImportant = (t.importance?.toLowerCase() == 'high');

    return Card(
      child: ListTile(
        leading: Icon(
          isImportant ? Icons.star : Icons.task_alt_outlined,
          color: isImportant ? Colors.amber : null,
        ),
        title: Text(t.title),
        subtitle: Text(
          [vm.assignees]
              .where((e) => e?.isNotEmpty == true)
              .join(' • '),
        ),
        trailing: Text(
          '${t.points} pts',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        onTap: () {
          // TODO: navigate to task details if needed
        },
        onLongPress: () =>
            ref.read(taskActionsProvider).quickComplete(t.id),
      ),
    );
  }
}
