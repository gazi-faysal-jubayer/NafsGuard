import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'deed_category.dart';

part 'deed.freezed.dart';
part 'deed.g.dart';

@freezed
abstract class Deed with _$Deed {
  const factory Deed({
    required String id,
    required String title,
    required DeedCategory category,
    int? durationSeconds,
    @Default(false) bool isCustom,
    int? iconCodePoint,
  }) = _Deed;

  factory Deed.fromJson(Map<String, dynamic> json) => _$DeedFromJson(json);
}

class DeedAdapter extends TypeAdapter<Deed> {
  @override
  final int typeId = 1;

  @override
  Deed read(BinaryReader reader) {
    final numFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return Deed(
      id: fields[0] as String,
      title: fields[1] as String,
      category: fields[2] as DeedCategory,
      durationSeconds: fields[3] as int?,
      isCustom: fields[4] as bool? ?? false,
      iconCodePoint: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Deed obj) {
    writer.writeByte(6);
    writer
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.durationSeconds)
      ..writeByte(4)
      ..write(obj.isCustom)
      ..writeByte(5)
      ..write(obj.iconCodePoint);
  }
}
