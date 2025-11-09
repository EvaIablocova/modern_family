// lib/app/router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/tasks/presentation/tasks_screen.dart';
import '../features/tasks/presentation/create_task_screen.dart';
import '../features/projects/presentation/projects_screen.dart';
import '../features/profiles/presentation/profiles_screen.dart';
import '../features/leaderboard/presentation/leaderboard_screen.dart';
import '../features/settings/presentation/settings_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  CustomTransitionPage<void> fadeSlide(GoRouterState state, Widget child) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curve = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curve,
          child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(0.02, 0), end: Offset.zero).animate(curve),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 220),
      reverseTransitionDuration: const Duration(milliseconds: 180),
    );
  }

  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => fadeSlide(state, const HomeScreen()),
      ),
      GoRoute(
        path: '/tasks',
        pageBuilder: (context, state) => fadeSlide(state, const TasksScreen()),
      ),
      GoRoute(
        path: '/tasks/new',
        pageBuilder: (context, state) => fadeSlide(state, const CreateTaskScreen()),
      ),
      GoRoute(
        path: '/projects',
        pageBuilder: (context, state) => fadeSlide(state, const ProjectsScreen()),
      ),
      GoRoute(
        path: '/profiles',
        pageBuilder: (context, state) => fadeSlide(state, const ProfilesScreen()),
      ),
      GoRoute(
        path: '/leaderboard',
        pageBuilder: (context, state) => fadeSlide(state, const LeaderboardScreen()),
      ),
      GoRoute(
        path: '/settings',
        pageBuilder: (context, state) => fadeSlide(state, const SettingsScreen()),
      ),
    ],
  );
});
