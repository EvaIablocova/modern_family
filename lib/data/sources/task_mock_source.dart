// lib/data/sources/task_mock_source.dart
import 'dart:async';
import 'package:dio/dio.dart';
import '../models/task.dart';
import 'task_remote_source.dart';

/// A mock implementation that overrides TaskRemoteSource methods to provide
/// in-memory sample data and simulate network latency.
class MockTaskRemoteSource extends TaskRemoteSource {
  MockTaskRemoteSource(Dio dio) : super(dio);

  static final DateTime _now = DateTime.now();

  static final List<Task> _tasks = [
    Task(
      id: 't1',
      title: 'Vacuum living room',
      description: 'Do a thorough vacuum including under the sofa',
      roomId: 'Living Room',
      projectId: 'p1',
      createdAt: _now.subtract(const Duration(days: 10)),
      dueAt: _now.subtract(const Duration(days: 2)),
      important: true,
      interval: TaskInterval.weekly,
      assigneeProfileIds: const ['alice'],
      points: 10,
    ),
    Task(
      id: 't2',
      title: 'Wipe kitchen counters',
      roomId: 'Kitchen',
      projectId: 'p1',
      createdAt: _now.subtract(const Duration(days: 5)),
      dueAt: DateTime(_now.year, _now.month, _now.day, 19),
      important: false,
      interval: TaskInterval.daily,
      assigneeProfileIds: const ['bob', 'alice'],
      points: 5,
    ),
    Task(
      id: 't3',
      title: 'Take out trash',
      roomId: 'Kitchen',
      createdAt: _now.subtract(const Duration(days: 1)),
      dueAt: _now.add(const Duration(days: 1)),
      important: false,
      interval: TaskInterval.daily,
      assigneeProfileIds: const ['bob'],
      points: 3,
    ),
    Task(
      id: 't4',
      title: 'Clean bathroom mirror',
      roomId: 'Bathroom',
      createdAt: _now.subtract(const Duration(days: 3)),
      dueAt: _now.add(const Duration(days: 5)),
      important: false,
      interval: TaskInterval.weekly,
      assigneeProfileIds: const ['carol'],
      points: 4,
    ),
  ];

  @override
  Future<List<Task>> list({String? status, DateTime? date}) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final base = date ?? _now;
    final todayStart = DateTime(base.year, base.month, base.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    Iterable<Task> filtered = _tasks;
    switch (status) {
      case 'overdue':
        filtered = _tasks.where((t) => t.dueAt != null && t.dueAt!.isBefore(todayStart) && t.completedAt == null);
        break;
      case 'today':
        filtered = _tasks.where((t) => t.dueAt != null && !t.dueAt!.isBefore(todayStart) && t.dueAt!.isBefore(todayEnd));
        break;
      case 'upcoming':
        filtered = _tasks.where((t) => t.dueAt != null && t.dueAt!.isAfter(todayEnd));
        break;
      default:
        break;
    }
    return filtered.toList();
  }

  @override
  Future<Task> create({
    required String title,
    String? description,
    DateTime? dueAt,
    bool important = false,
    TaskInterval interval = TaskInterval.none,
    int points = 5,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final t = Task(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
      dueAt: dueAt,
      important: important,
      interval: interval,
      assigneeProfileIds: const [],
      points: points,
    );
    _tasks.add(t);
    return t;
  }

  @override
  Future<void> complete(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final i = _tasks.indexWhere((t) => t.id == id);
    if (i != -1) {
      _tasks[i] = _tasks[i].copyWith(completedAt: DateTime.now());
    }
  }
}
