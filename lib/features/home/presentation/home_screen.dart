// lib/features/home/presentation/home_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../shared/widgets/footer_nav.dart';
import '../../../state/task_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overdue = ref.watch(overdueTasksProvider);
    final today = ref.watch(todayTasksProvider);
    final upcoming = ref.watch(upcomingTasksProvider);

    int len(AsyncValue<List<dynamic>> v) => v.maybeWhen(data: (d) => d.length, orElse: () => 0);

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Modern Family'),
            SizedBox(height: 2),
            Text('Welcome, Eva!', style: TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _QuickStatCard(
            title: 'Overdue',
            count: len(overdue),
            color: Colors.red.shade400,
            onTap: () => context.go('/tasks'),
            icon: Icons.warning_amber_rounded,
          ),
          const SizedBox(height: 12),
          _QuickStatCard(
            title: 'Today',
            count: len(today),
            color: Colors.teal.shade400,
            onTap: () => context.go('/tasks'),
            icon: Icons.calendar_today_outlined,
          ),
          const SizedBox(height: 12),
          _QuickStatCard(
            title: 'Upcoming',
            count: len(upcoming),
            color: Colors.indigo.shade400,
            onTap: () => context.go('/tasks'),
            icon: Icons.upcoming_outlined,
          ),
          const SizedBox(height: 24),
          const _AnalyticsPreview(),
          const SizedBox(height: 24),
          const Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _NavTile(label: 'Tasks', icon: Icons.checklist_outlined, route: '/tasks'),
              _NavTile(label: 'Projects', icon: Icons.inventory_2_outlined, route: '/projects'),
              _NavTile(label: 'Rank', icon: Icons.emoji_events_outlined, route: '/leaderboard'),
              _NavTile(label: 'Profiles', icon: Icons.group_outlined, route: '/profiles'),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const FooterNav(index: 0),
    );
  }
}

class _QuickStatCard extends StatelessWidget {
  const _QuickStatCard({
    required this.title,
    required this.count,
    required this.color,
    required this.onTap,
    required this.icon,
  });

  final String title;
  final int count;
  final Color color;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: color, child: Icon(icon, color: Colors.white)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text('$count items', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700])),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnalyticsPreview extends ConsumerWidget {
  const _AnalyticsPreview();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = ref.watch(todayTasksProvider);
    final overdue = ref.watch(overdueTasksProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.insights_outlined),
                const SizedBox(width: 8),
                Text('Household analytics', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _SparkBar(value: _ratio(today), label: 'Today load'),
                _SparkBar(value: _ratio(overdue), label: 'Overdue load'),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Keep overdue low and aim 3+ tasks/day to stay tidy.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
            )
          ],
        ),
      ),
    );
  }

  double _ratio(AsyncValue<List<dynamic>> v) => v.maybeWhen(data: (d) => (d.length.clamp(0, 10)) / 10.0, orElse: () => 0.0);
}

class _SparkBar extends StatelessWidget {
  const _SparkBar({required this.value, required this.label});
  final double value; // 0..1
  final String label;

  @override
  Widget build(BuildContext context) {
    final color = value < 0.3 ? Colors.teal : (value < 0.7 ? Colors.amber : Colors.redAccent);
    return Column(
      children: [
        Container(
          width: 120,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: value,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(label),
      ],
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({required this.label, required this.icon, required this.route});
  final String label;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 16 * 2 - 12) / 2,
      child: Card(
        child: InkWell(
          onTap: () => context.go(route),
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 28),
                const SizedBox(height: 8),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
