// lib/features/tasks/presentation/widgets/task_card.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../data/models/task.dart';
import '../../../../state/task_providers.dart';

class TaskViewModel {
  TaskViewModel(this.task, {required this.roomName, required this.assignees});
  final Task task;
  final String? roomName;
  final String assignees;
}

class TaskCard extends ConsumerWidget {
  const TaskCard({super.key, required this.vm});
  final TaskViewModel vm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = vm.task;
    return Card(
      child: ListTile(
        leading: Icon(
          t.important ? Icons.star : Icons.task_alt_outlined,
          color: t.important ? Colors.amber : null,
        ),
        title: Text(t.title),
        subtitle: Text([vm.roomName, vm.assignees].where((e) => e?.isNotEmpty == true).join(' • ')),
        trailing: Text('${t.points} pts', style: const TextStyle(fontWeight: FontWeight.w600)),
        onTap: () {},
        onLongPress: () => ref.read(taskActionsProvider).quickComplete(t.id),
      ),
    );
  }
}
