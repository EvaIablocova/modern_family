// lib/shared/widgets/async_empty_error.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AsyncEmptyError<T> extends StatelessWidget {
  const AsyncEmptyError({super.key, required this.value, required this.builder, this.empty});

  final AsyncValue<T> value;
  final Widget Function(T data) builder;
  final Widget? empty;

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (data) {
        if (data is Iterable && (data as Iterable).isEmpty) {
          return empty ?? const Center(child: Text('Nothing here'));
        }
        return builder(data);
      },
    );
  }
}
