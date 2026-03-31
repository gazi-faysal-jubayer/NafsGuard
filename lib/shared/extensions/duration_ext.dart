extension DurationExt on Duration {
  String toCountdown() {
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String toReadable() {
    if (inHours > 0) {
      return '${inHours}h ${inMinutes.remainder(60)}m';
    }
    if (inMinutes > 0) {
      return '${inMinutes}m ${inSeconds.remainder(60)}s';
    }
    return '${inSeconds}s';
  }
}
