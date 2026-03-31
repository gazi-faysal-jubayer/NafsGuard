abstract final class NafsDurations {
  static const int defaultCycleSeconds = 1500; // 25 minutes
  static const int minCycleMinutes = 15;
  static const int maxCycleMinutes = 60;
  static const int holdButtonDurationMs = 2000;

  static const Duration screenTransition = Duration(milliseconds: 400);
  static const Duration fadeIn = Duration(milliseconds: 600);
  static const Duration quickFade = Duration(milliseconds: 200);
  static const Duration slotSpinDuration = Duration(milliseconds: 2500);
  static const Duration slotCascadeDelay = Duration(milliseconds: 300);
  static const Duration holdButton = Duration(milliseconds: 2000);
  static const Duration confettiBurst = Duration(seconds: 3);
  static const Duration volumeRamp = Duration(seconds: 3);
  static const Duration counterTick = Duration(seconds: 1);
}
