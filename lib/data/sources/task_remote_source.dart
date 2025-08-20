// lib/data/sources/task_remote_source.dart
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/task.dart';
import '../../core/network/api_client.dart';
import '../../state/app_providers.dart';
import 'task_mock_source.dart';

final taskRemoteSourceProvider = Provider<TaskRemoteSource>((ref) {
  final useMocks = ref.watch(useMocksProvider);
  final dio = ref.watch(dioProvider);
  if (useMocks) {
    return MockTaskRemoteSource(dio);
  }
  return TaskRemoteSource(dio);
});

class TaskRemoteSource {
  TaskRemoteSource(this._dio);
  final Dio _dio;

  Future<List<Task>> list({String? status, DateTime? date}) async {
    final res = await _dio.get('/tasks', queryParameters: {
      'status': status,
      if (date != null) 'date': date.toIso8601String(),
    });
    return (res.data as List).map((j) => Task.fromJson(j as Map<String, dynamic>)).toList();
  }

  Future<Task> create({
    required String title,
    String? description,
    DateTime? dueAt,
    bool important = false,
    TaskInterval interval = TaskInterval.none,
    int points = 5,
  }) async {
    final res = await _dio.post('/tasks', data: {
      'title': title,
      'description': description,
      'dueAt': dueAt?.toIso8601String(),
      'important': important,
      'interval': interval.name,
      'points': points,
    });
    return Task.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> complete(String id) => _dio.post('/tasks/$id/complete');
}
