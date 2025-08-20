// lib/state/app_providers.dart
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Toggle to use local mock sources instead of HTTP.
final useMocksProvider = StateProvider<bool>((_) => true);
