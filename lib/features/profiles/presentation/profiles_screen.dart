// lib/features/profiles/presentation/profiles_screen.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../shared/widgets/footer_nav.dart';

class ProfilesScreen extends ConsumerWidget {
  const ProfilesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Profiles')),
      body: Center(child: Text('Profiles will appear here')),
      bottomNavigationBar: FooterNav(index: 4),
    );
  }
}
