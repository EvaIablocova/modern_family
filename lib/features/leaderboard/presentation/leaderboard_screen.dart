// lib/features/leaderboard/presentation/leaderboard_screen.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../shared/widgets/footer_nav.dart';
import '../../../state/leaderboard_providers.dart';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(leaderboardPeriodProvider);
    final leaderboard = ref.watch(leaderboardProvider);
    final achievements = ref.watch(achievementsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        actions: [
          PopupMenuButton<LeaderboardPeriod>(
            initialValue: period,
            onSelected: (p) => ref.read(leaderboardPeriodProvider.notifier).state = p,
            itemBuilder: (ctx) => const [
              PopupMenuItem(value: LeaderboardPeriod.week, child: Text('This week')),
              PopupMenuItem(value: LeaderboardPeriod.month, child: Text('This month')),
              PopupMenuItem(value: LeaderboardPeriod.year, child: Text('This year')),
              PopupMenuItem(value: LeaderboardPeriod.all, child: Text('All time')),
            ],
            icon: const Icon(Icons.filter_list_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Achievements', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: achievements
                .map((a) => Chip(
                      avatar: Icon(a.icon, size: 18),
                      label: Text(a.label),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          Text('Leaders', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          leaderboard.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (list) => list.isEmpty
                ? const Center(child: Text('No entries'))
                : Column(
                    children: list
                        .map(
                          (e) => Card(
                            child: ListTile(
                              leading: CircleAvatar(child: Text('#${e.rank}')),
                              title: Text(e.name),
                              trailing: Text('${e.points} pts'),
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const FooterNav(index: 2),
    );
  }
}
