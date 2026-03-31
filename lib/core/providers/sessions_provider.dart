import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/session.dart';

class SessionsRepository {
  static const _boxName = 'sessions_box';

  Future<Box<Session>> _getBox() => Hive.openBox<Session>(_boxName);

  Future<List<Session>> getAllSessions() async {
    final box = await _getBox();
    final sessions = box.values.toList()
      ..sort((a, b) => b.startTime.compareTo(a.startTime));
    return sessions;
  }

  Future<void> addSession(Session session) async {
    final box = await _getBox();
    await box.put(session.id, session);
  }

  Future<List<Session>> getTodaySessions() async {
    final all = await getAllSessions();
    final now = DateTime.now();
    return all.where((s) {
      return s.startTime.year == now.year &&
          s.startTime.month == now.month &&
          s.startTime.day == now.day;
    }).toList();
  }
}

final sessionsRepositoryProvider = Provider<SessionsRepository>((ref) {
  return SessionsRepository();
});

final sessionsProvider = FutureProvider<List<Session>>((ref) async {
  final repo = ref.read(sessionsRepositoryProvider);
  return repo.getAllSessions();
});

final barakahTodayProvider = FutureProvider<int>((ref) async {
  final sessions = await ref.watch(sessionsProvider.future);
  final now = DateTime.now();
  return sessions
      .where((s) =>
          s.deedCompleted != null &&
          s.startTime.year == now.year &&
          s.startTime.month == now.month &&
          s.startTime.day == now.day)
      .fold<int>(0, (sum, s) => sum + s.barakahEarned);
});

final streakProvider = FutureProvider<int>((ref) async {
  final sessions = await ref.watch(sessionsProvider.future);
  if (sessions.isEmpty) return 0;

  final deedsCompleted =
      sessions.where((s) => s.deedCompleted != null).toList();
  if (deedsCompleted.isEmpty) return 0;

  final daysWithDeeds = <DateTime>{};
  for (final s in deedsCompleted) {
    daysWithDeeds.add(DateTime(
      s.startTime.year,
      s.startTime.month,
      s.startTime.day,
    ));
  }

  final sortedDays = daysWithDeeds.toList()..sort((a, b) => b.compareTo(a));

  int streak = 0;
  var expectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  for (final day in sortedDays) {
    if (day == expectedDay) {
      streak++;
      expectedDay = expectedDay.subtract(const Duration(days: 1));
    } else if (day.isBefore(expectedDay)) {
      break;
    }
  }

  return streak;
});

final weeklyDeedsProvider = FutureProvider<Map<int, int>>((ref) async {
  final sessions = await ref.watch(sessionsProvider.future);
  final now = DateTime.now();
  final weekStart = now.subtract(Duration(days: now.weekday - 1));

  final weeklyMap = <int, int>{};
  for (int i = 0; i < 7; i++) {
    weeklyMap[i] = 0;
  }

  for (final s in sessions) {
    if (s.deedCompleted == null) continue;
    final daysSinceWeekStart = s.startTime
        .difference(DateTime(weekStart.year, weekStart.month, weekStart.day))
        .inDays;
    if (daysSinceWeekStart >= 0 && daysSinceWeekStart < 7) {
      weeklyMap[daysSinceWeekStart] =
          (weeklyMap[daysSinceWeekStart] ?? 0) + 1;
    }
  }

  return weeklyMap;
});
