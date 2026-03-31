import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/models/deed.dart';
import '../core/providers/settings_provider.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/home/home_screen.dart';
import '../features/blockade/blockade_screen.dart';
import '../features/deed_spin/deed_spin_screen.dart';
import '../features/deed_task/deed_task_screen.dart';
import '../features/history/history_screen.dart';
import '../features/settings/settings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final settings = ref.watch(settingsProvider);

  return GoRouter(
    initialLocation: settings.onboardingCompleted ? '/home' : '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: '/blockade',
        name: 'blockade',
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const BlockadeScreen(),
        ),
      ),
      GoRoute(
        path: '/deed-spin',
        name: 'deed-spin',
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const DeedSpinScreen(),
        ),
      ),
      GoRoute(
        path: '/deed-task',
        name: 'deed-task',
        pageBuilder: (context, state) {
          final deed = state.extra as Deed;
          return _buildPage(
            key: state.pageKey,
            child: DeedTaskScreen(deed: deed),
          );
        },
      ),
      GoRoute(
        path: '/history',
        name: 'history',
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const HistoryScreen(),
        ),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const SettingsScreen(),
        ),
      ),
    ],
  );
});

CustomTransitionPage<void> _buildPage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fadeAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      );
      final slideAnimation = Tween<Offset>(
        begin: const Offset(0, 0.05),
        end: Offset.zero,
      ).animate(fadeAnimation);

      return FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: child,
        ),
      );
    },
  );
}
