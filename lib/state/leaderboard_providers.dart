import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Периоды для фильтрации лидерборда
enum LeaderboardPeriod { week, month, year, all }

/// Модель участника лидерборда
class LeaderboardEntry {
  final int rank;
  final String name;
  final int points;

  LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.points,
  });
}

/// Модель достижения
class Achievement {
  final IconData icon;
  final String label;

  Achievement({required this.icon, required this.label});
}

/// Провайдер для выбранного периода
final leaderboardPeriodProvider =
StateProvider<LeaderboardPeriod>((ref) => LeaderboardPeriod.week);

/// Провайдер достижений (пока статический список)
final achievementsProvider = Provider<List<Achievement>>((ref) {
  return [
    Achievement(icon: Icons.star, label: "Top scorer"),
    Achievement(icon: Icons.flash_on, label: "Fastest growth"),
    Achievement(icon: Icons.emoji_events, label: "Most consistent"),
  ];
});

/// Провайдер лидерборда (имитация загрузки данных)
final leaderboardProvider =
FutureProvider<List<LeaderboardEntry>>((ref) async {
  final period = ref.watch(leaderboardPeriodProvider);

  // Здесь можно сделать реальный API-запрос в зависимости от периода
  await Future.delayed(const Duration(seconds: 1)); // имитация сети

  switch (period) {
    case LeaderboardPeriod.week:
      return [
        LeaderboardEntry(rank: 1, name: "Alice", points: 120),
        LeaderboardEntry(rank: 2, name: "Bob", points: 95),
        LeaderboardEntry(rank: 3, name: "Charlie", points: 80),
      ];
    case LeaderboardPeriod.month:
      return [
        LeaderboardEntry(rank: 1, name: "Alice", points: 450),
        LeaderboardEntry(rank: 2, name: "Charlie", points: 420),
        LeaderboardEntry(rank: 3, name: "Bob", points: 390),
      ];
    case LeaderboardPeriod.year:
      return [
        LeaderboardEntry(rank: 1, name: "Charlie", points: 5000),
        LeaderboardEntry(rank: 2, name: "Alice", points: 4800),
        LeaderboardEntry(rank: 3, name: "Bob", points: 4700),
      ];
    case LeaderboardPeriod.all:
      return [
        LeaderboardEntry(rank: 1, name: "Alice", points: 12000),
        LeaderboardEntry(rank: 2, name: "Charlie", points: 11500),
        LeaderboardEntry(rank: 3, name: "Bob", points: 11000),
      ];
  }
});
