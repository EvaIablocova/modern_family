// lib/data/models/leaderboard_entry.dart
import 'package:flutter/material.dart';

class LeaderboardEntry {
  LeaderboardEntry({
    required this.profileId,
    required this.name,
    required this.points,
    this.rank = 0,
  });

  final String profileId;
  final String name;
  final int points;
  final int rank;

  LeaderboardEntry copyWith({int? rank, int? points}) => LeaderboardEntry(
        profileId: profileId,
        name: name,
        points: points ?? this.points,
        rank: rank ?? this.rank,
      );
}

class Achievement {
  Achievement(this.label, this.icon);
  final String label;
  final IconData icon;
}
