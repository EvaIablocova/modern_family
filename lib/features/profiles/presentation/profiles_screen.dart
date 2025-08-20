// lib/features/profiles/presentation/profiles_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../shared/widgets/footer_nav.dart';
import '../../../state/profile_providers.dart';

class ProfilesScreen extends ConsumerWidget {
  const ProfilesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(profilesProvider);
    final logs = ref.watch(profileLogsProvider);
    final remindersEnabled = ref.watch(remindersEnabledProvider);
    final vacationMode = ref.watch(vacationModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.group_outlined),
                      const SizedBox(width: 8),
                      Text('Family profiles', style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 12),
                  profiles.when(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Text('Error: $e'),
                    data: (list) => Column(
                      children: list
                          .map((p) => ListTile(
                                leading: CircleAvatar(child: Text(p.name[0])),
                                title: Text(p.name),
                                subtitle: Text('${p.points} pts${p.isChild ? ' · Child' : ''}'),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: SwitchListTile(
              value: remindersEnabled,
              onChanged: (v) => ref.read(remindersEnabledProvider.notifier).state = v,
              title: const Text('Reminders'),
              subtitle: const Text('Receive reminders for due tasks'),
              secondary: const Icon(Icons.notifications_active_outlined),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: SwitchListTile(
              value: vacationMode,
              onChanged: (v) => ref.read(vacationModeProvider.notifier).state = v,
              title: const Text('Vacation mode'),
              subtitle: const Text('Pause schedules and notifications'),
              secondary: const Icon(Icons.beach_access_outlined),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Account settings'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/settings'),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.history_outlined),
                      const SizedBox(width: 8),
                      Text('Logs', style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 12),
                  logs.when(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Text('Error: $e'),
                    data: (list) => Column(
                      children: list
                          .map((l) => ListTile(
                                dense: true,
                                leading: const Icon(Icons.circle, size: 8),
                                title: Text(l.message),
                                subtitle: Text(_relative(l.at)),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const FooterNav(index: 4),
    );
  }

  String _relative(DateTime at) {
    final d = DateTime.now().difference(at);
    if (d.inMinutes < 60) return '${d.inMinutes}m ago';
    if (d.inHours < 24) return '${d.inHours}h ago';
    return '${d.inDays}d ago';
  }
}
