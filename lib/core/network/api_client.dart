// lib/core/network/api_client.dart
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../config/environment.dart';
import 'interceptors.dart';

final dioProvider = Provider<Dio>((ref) {
  final env = ref.watch(environmentProvider);
  final dio = Dio(BaseOptions(baseUrl: env.apiBaseUrl, headers: {'Accept': 'application/json'}));
  dio.interceptors.addAll([
    AuthInterceptor(ref),
    LogInterceptor(requestBody: true, responseBody: false),
  ]);
  return dio;
});
