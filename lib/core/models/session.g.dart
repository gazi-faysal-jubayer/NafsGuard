// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Session _$SessionFromJson(Map<String, dynamic> json) => _Session(
  id: json['id'] as String,
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: json['endTime'] == null
      ? null
      : DateTime.parse(json['endTime'] as String),
  deedCompleted: json['deedCompleted'] == null
      ? null
      : Deed.fromJson(json['deedCompleted'] as Map<String, dynamic>),
  bypassUsed: json['bypassUsed'] as bool? ?? false,
  barakahEarned: (json['barakahEarned'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$SessionToJson(_Session instance) => <String, dynamic>{
  'id': instance.id,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime?.toIso8601String(),
  'deedCompleted': instance.deedCompleted,
  'bypassUsed': instance.bypassUsed,
  'barakahEarned': instance.barakahEarned,
};
