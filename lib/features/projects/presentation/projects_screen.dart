// lib/features/projects/presentation/projects_screen.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../shared/widgets/footer_nav.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Projects')),
      body: Center(child: Text('Projects will appear here')),
      bottomNavigationBar: FooterNav(index: 3),
    );
  }
}
