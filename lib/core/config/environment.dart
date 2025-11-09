// lib/core/config/environment.dart
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Environment {
  const Environment({
    required this.apiBaseUrl,
    this.basicUser,
    this.basicPassword,
  });
  final String apiBaseUrl;
  final String? basicUser;
  final String? basicPassword;

  factory Environment.fromEnv() {
    const baseUrl = String.fromEnvironment('BASE_URL', defaultValue: 'http://localhost:8080');
    const user = String.fromEnvironment('BASIC_USER');
    const pass = String.fromEnvironment('BASIC_PASSWORD');
    return Environment(apiBaseUrl: baseUrl, basicUser: user.isEmpty ? null : user, basicPassword: pass.isEmpty ? null : pass);
  }
}

final environmentProvider = Provider<Environment>((_) => Environment.fromEnv());
