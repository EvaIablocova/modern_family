// lib/core/config/environment.dart
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Environment {
  const Environment({required this.apiBaseUrl});
  final String apiBaseUrl;
}

final environmentProvider = Provider<Environment>((_) => const Environment(apiBaseUrl: 'http://localhost:8080'));
