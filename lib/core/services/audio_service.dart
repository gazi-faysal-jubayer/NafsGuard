import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import '../constants/assets.dart';

class AudioService {
  static final AudioService _instance = AudioService._();
  factory AudioService() => _instance;
  AudioService._();

  final AudioPlayer _player = AudioPlayer();
  Timer? _volumeRampTimer;

  Future<void> playBlockadeAlert(String audioPath) async {
    try {
      await _player.setVolume(0);
      await _player.setSource(AssetSource(
        audioPath.replaceFirst('assets/', ''),
      ));
      await _player.resume();
      _rampVolume();
    } catch (_) {
      // Silently fail; snackbar shown by caller if needed
    }
  }

  void _rampVolume() {
    double volume = 0;
    _volumeRampTimer?.cancel();
    _volumeRampTimer = Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        volume += 0.033; // ~3 seconds to full volume
        if (volume >= 1.0) {
          volume = 1.0;
          timer.cancel();
        }
        _player.setVolume(volume);
      },
    );
  }

  Future<void> playCompletionChime() async {
    try {
      await _player.setVolume(0.8);
      await _player.setSource(AssetSource(
        NafsAssets.completionChime.replaceFirst('assets/', ''),
      ));
      await _player.resume();
    } catch (_) {}
  }

  Future<void> playPreview(String audioPath) async {
    try {
      await _player.setVolume(0.6);
      if (audioPath.startsWith('assets/')) {
        await _player.setSource(AssetSource(
          audioPath.replaceFirst('assets/', ''),
        ));
      } else {
        await _player.setSource(DeviceFileSource(audioPath));
      }
      await _player.resume();
    } catch (_) {}
  }

  Future<void> stop() async {
    _volumeRampTimer?.cancel();
    await _player.stop();
  }

  void dispose() {
    _volumeRampTimer?.cancel();
    _player.dispose();
  }
}
