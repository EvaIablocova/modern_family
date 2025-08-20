// lib/main.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app/app.dart';
import 'core/config/environment.dart';
import 'state/app_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const env = Environment(
    apiBaseUrl: String.fromEnvironment('API_BASE_URL', defaultValue: 'http://10.0.2.2:8080'),
  );
  const useMocks = bool.fromEnvironment('USE_MOCKS', defaultValue: true);

  runApp(ProviderScope(
    overrides: [
      environmentProvider.overrideWithValue(env),
      useMocksProvider.overrideWith((ref) => useMocks),
    ],
    child: const BetidyApp(),
  ));
}
