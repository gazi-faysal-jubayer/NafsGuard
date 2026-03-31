import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'deed.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
abstract class Session with _$Session {
  const factory Session({
    required String id,
    required DateTime startTime,
    DateTime? endTime,
    Deed? deedCompleted,
    @Default(false) bool bypassUsed,
    @Default(1) int barakahEarned,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
}

class SessionAdapter extends TypeAdapter<Session> {
  @override
  final int typeId = 2;

  @override
  Session read(BinaryReader reader) {
    final numFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return Session(
      id: fields[0] as String,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as DateTime?,
      deedCompleted: fields[3] as Deed?,
      bypassUsed: fields[4] as bool? ?? false,
      barakahEarned: fields[5] as int? ?? 1,
    );
  }

  @override
  void write(BinaryWriter writer, Session obj) {
    writer.writeByte(6);
    writer
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.deedCompleted)
      ..writeByte(4)
      ..write(obj.bypassUsed)
      ..writeByte(5)
      ..write(obj.barakahEarned);
  }
}
