// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Deed _$DeedFromJson(Map<String, dynamic> json) => _Deed(
  id: json['id'] as String,
  title: json['title'] as String,
  category: $enumDecode(_$DeedCategoryEnumMap, json['category']),
  durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
  isCustom: json['isCustom'] as bool? ?? false,
  iconCodePoint: (json['iconCodePoint'] as num?)?.toInt(),
);

Map<String, dynamic> _$DeedToJson(_Deed instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'category': _$DeedCategoryEnumMap[instance.category]!,
  'durationSeconds': instance.durationSeconds,
  'isCustom': instance.isCustom,
  'iconCodePoint': instance.iconCodePoint,
};

const _$DeedCategoryEnumMap = {
  DeedCategory.tongue: 'tongue',
  DeedCategory.action: 'action',
  DeedCategory.knowledge: 'knowledge',
  DeedCategory.physical: 'physical',
};
