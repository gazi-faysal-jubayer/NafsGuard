import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/deed.dart';
import '../services/screen_time_service.dart';

import '../constants/durations.dart';

class CycleState {
  final bool isRunning;
  final int elapsedSeconds;
  final int totalSeconds;
  final bool isBlocked;
  final Deed? currentDeed;
  final int bypassCount;

  const CycleState({
    this.isRunning = false,
    this.elapsedSeconds = 0,
    this.totalSeconds = NafsDurations.defaultCycleSeconds,
    this.isBlocked = false,
    this.currentDeed,
    this.bypassCount = 0,
  });

  int get remainingSeconds => (totalSeconds - elapsedSeconds).clamp(0, totalSeconds);
  double get progress => totalSeconds > 0 ? elapsedSeconds / totalSeconds : 0;

  CycleState copyWith({
    bool? isRunning,
    int? elapsedSeconds,
    int? totalSeconds,
    bool? isBlocked,
    Deed? currentDeed,
    int? bypassCount,
    bool clearDeed = false,
  }) {
    return CycleState(
      isRunning: isRunning ?? this.isRunning,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      isBlocked: isBlocked ?? this.isBlocked,
      currentDeed: clearDeed ? null : (currentDeed ?? this.currentDeed),
      bypassCount: bypassCount ?? this.bypassCount,
    );
  }
}

class CycleNotifier extends StateNotifier<CycleState> {
  CycleNotifier() : super(const CycleState());

  Timer? _ticker;
  final _screenTimeService = ScreenTimeService();

  void startCycle({int? durationMinutes}) {
    final totalSeconds = (durationMinutes ?? 25) * 60;
    state = CycleState(
      isRunning: true,
      totalSeconds: totalSeconds,
    );
    _screenTimeService.cycleDurationSeconds = totalSeconds;
    _screenTimeService.startTracking();
    _startTicker();
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(
      NafsDurations.counterTick,
      (_) => tick(),
    );
  }

  void tick() {
    if (!state.isRunning) return;

    final newElapsed = state.elapsedSeconds + 1;
    if (newElapsed >= state.totalSeconds) {
      triggerBlockade();
    } else {
      state = state.copyWith(elapsedSeconds: newElapsed);
    }
  }

  void triggerBlockade() {
    _ticker?.cancel();
    state = state.copyWith(
      isRunning: false,
      isBlocked: true,
      elapsedSeconds: state.totalSeconds,
    );
  }

  void setCurrentDeed(Deed deed) {
    state = state.copyWith(currentDeed: deed);
  }

  void completeDeed() {
    state = state.copyWith(
      isBlocked: false,
      clearDeed: true,
    );
    resetCycle();
  }

  void bypass({int penaltyMinutes = 0}) {
    state = state.copyWith(
      isBlocked: false,
      bypassCount: state.bypassCount + 1,
      clearDeed: true,
    );
    if (penaltyMinutes > 0) {
      _screenTimeService.addPenalty(penaltyMinutes);
    }
    resetCycle();
  }

  void resetCycle() {
    _screenTimeService.resetCycle();
    state = state.copyWith(
      isRunning: true,
      elapsedSeconds: 0,
    );
    _startTicker();
  }

  void updateDuration(int minutes) {
    state = state.copyWith(totalSeconds: minutes * 60);
    _screenTimeService.cycleDurationSeconds = minutes * 60;
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}

final cycleStateProvider =
    StateNotifierProvider<CycleNotifier, CycleState>((ref) {
  return CycleNotifier();
});
