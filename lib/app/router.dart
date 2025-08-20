// lib/app/router.dart
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/tasks/presentation/tasks_screen.dart';
import '../features/tasks/presentation/create_task_screen.dart';
import '../features/projects/presentation/projects_screen.dart';
import '../features/profiles/presentation/profiles_screen.dart';
import '../features/leaderboard/presentation/leaderboard_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/tasks', builder: (_, __) => const TasksScreen()),
      GoRoute(path: '/tasks/new', builder: (_, __) => const CreateTaskScreen()),
      GoRoute(path: '/projects', builder: (_, __) => const ProjectsScreen()),
      GoRoute(path: '/profiles', builder: (_, __) => const ProfilesScreen()),
      GoRoute(path: '/leaderboard', builder: (_, __) => const LeaderboardScreen()),
    ],
  );
});
