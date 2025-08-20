// lib/state/profile_providers.dart
import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../data/models/profile.dart';

class ProfileLog {
  ProfileLog({required this.id, required this.message, required this.at});
  final String id;
  final String message;
  final DateTime at;
}

/// Household profiles (mocked)
final profilesProvider = FutureProvider<List<Profile>>((ref) async {
  await Future<void>.delayed(const Duration(milliseconds: 200));
  return const [
    Profile(id: 'alice', name: 'Alice', points: 120),
    Profile(id: 'bob', name: 'Bob', points: 95),
    Profile(id: 'carol', name: 'Carol', points: 60, isChild: true),
  ];
});

/// Activity logs (mocked)
final profileLogsProvider = FutureProvider<List<ProfileLog>>((ref) async {
  await Future<void>.delayed(const Duration(milliseconds: 250));
  final now = DateTime.now();
  return [
    ProfileLog(id: 'l1', message: 'Alice completed "Vacuum living room"', at: now.subtract(const Duration(hours: 2))),
    ProfileLog(id: 'l2', message: 'Bob created task "Wipe kitchen counters"', at: now.subtract(const Duration(days: 1, hours: 3))),
    ProfileLog(id: 'l3', message: 'Carol joined the family', at: now.subtract(const Duration(days: 3))),
  ];
});

/// Notifications toggle
final remindersEnabledProvider = StateProvider<bool>((_) => true);

/// Vacation mode toggle
final vacationModeProvider = StateProvider<bool>((_) => false);
