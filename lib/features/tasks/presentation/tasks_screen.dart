// lib/features/tasks/presentation/tasks_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../shared/widgets/footer_nav.dart';
import '../../../state/task_providers.dart';
import 'widgets/task_card.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});
  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> with SingleTickerProviderStateMixin {
  late final TabController _tab;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  void _pickDay() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 2),
      initialDate: _focusedDay,
    );
    if (picked != null) {
      setState(() => _focusedDay = picked);
      final normalized = DateTime(picked.year, picked.month, picked.day);
      ref.read(selectedDateProvider.notifier).state = normalized;
    }
  }

  @override
  Widget build(BuildContext context) {
    final overdue = ref.watch(overdueTasksProvider);
    final today = ref.watch(todayTasksProvider);
    final upcoming = ref.watch(upcomingTasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        bottom: TabBar(
          controller: _tab,
          tabs: const [Tab(text: 'Overdue'), Tab(text: 'Today'), Tab(text: 'Upcoming')],
        ),
        actions: [
          IconButton(onPressed: _pickDay, icon: const Icon(Icons.calendar_month)),
          IconButton(onPressed: () => context.push('/tasks/new'), icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          _CalendarRibbon(
            date: _focusedDay,
            onPrev: () {
              final d = _focusedDay.subtract(const Duration(days: 1));
              setState(() => _focusedDay = d);
              ref.read(selectedDateProvider.notifier).state = DateTime(d.year, d.month, d.day);
            },
            onNext: () {
              final d = _focusedDay.add(const Duration(days: 1));
              setState(() => _focusedDay = d);
              ref.read(selectedDateProvider.notifier).state = DateTime(d.year, d.month, d.day);
            },
            onToday: () {
              final d = DateTime.now();
              setState(() => _focusedDay = d);
              ref.read(selectedDateProvider.notifier).state = DateTime(d.year, d.month, d.day);
            },
          ),
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                _TaskList(state: overdue),
                _TaskList(state: today),
                _TaskList(state: upcoming),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const FooterNav(index: 1),
    );
  }
}

class _CalendarRibbon extends StatelessWidget {
  const _CalendarRibbon({required this.date, required this.onPrev, required this.onNext, required this.onToday});
  final DateTime date;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onToday;

  @override
  Widget build(BuildContext context) {
    final d = date;
    final label = '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          IconButton(onPressed: onPrev, icon: const Icon(Icons.chevron_left)),
          Expanded(
            child: Text(label, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium),
          ),
          IconButton(onPressed: onNext, icon: const Icon(Icons.chevron_right)),
          const SizedBox(width: 8),
          TextButton(onPressed: onToday, child: const Text('Today')),
        ],
      ),
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList({required this.state});
  final AsyncValue<List<TaskViewModel>> state;

  @override
  Widget build(BuildContext context) {
    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (tasks) => tasks.isEmpty
          ? const Center(child: Text('No tasks'))
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (_, i) => TaskCard(vm: tasks[i]),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
      ),
    );
  }
}
