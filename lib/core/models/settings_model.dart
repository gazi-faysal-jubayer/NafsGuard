import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
abstract class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    @Default(25) int cycleDurationMinutes,
    @Default('assets/audio/adhan_snippet.mp3') String audioPath,
    @Default(false) bool emergencyBypassEnabled,
    @Default(10) int bypassPenaltyMinutes,
    @Default(false) bool onboardingCompleted,
  }) = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);
}

class SettingsModelAdapter extends TypeAdapter<SettingsModel> {
  @override
  final int typeId = 3;

  @override
  SettingsModel read(BinaryReader reader) {
    final numFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return SettingsModel(
      cycleDurationMinutes: fields[0] as int? ?? 25,
      audioPath:
          fields[1] as String? ?? 'assets/audio/adhan_snippet.mp3',
      emergencyBypassEnabled: fields[2] as bool? ?? false,
      bypassPenaltyMinutes: fields[3] as int? ?? 10,
      onboardingCompleted: fields[4] as bool? ?? false,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsModel obj) {
    writer.writeByte(5);
    writer
      ..writeByte(0)
      ..write(obj.cycleDurationMinutes)
      ..writeByte(1)
      ..write(obj.audioPath)
      ..writeByte(2)
      ..write(obj.emergencyBypassEnabled)
      ..writeByte(3)
      ..write(obj.bypassPenaltyMinutes)
      ..writeByte(4)
      ..write(obj.onboardingCompleted);
  }
}
