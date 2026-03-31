// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsModel _$SettingsModelFromJson(
  Map<String, dynamic> json,
) => _SettingsModel(
  cycleDurationMinutes: (json['cycleDurationMinutes'] as num?)?.toInt() ?? 25,
  audioPath: json['audioPath'] as String? ?? 'assets/audio/adhan_snippet.mp3',
  emergencyBypassEnabled: json['emergencyBypassEnabled'] as bool? ?? false,
  bypassPenaltyMinutes: (json['bypassPenaltyMinutes'] as num?)?.toInt() ?? 10,
  onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
);

Map<String, dynamic> _$SettingsModelToJson(_SettingsModel instance) =>
    <String, dynamic>{
      'cycleDurationMinutes': instance.cycleDurationMinutes,
      'audioPath': instance.audioPath,
      'emergencyBypassEnabled': instance.emergencyBypassEnabled,
      'bypassPenaltyMinutes': instance.bypassPenaltyMinutes,
      'onboardingCompleted': instance.onboardingCompleted,
    };
