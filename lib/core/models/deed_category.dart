import 'package:hive/hive.dart';

enum DeedCategory {
  tongue,
  action,
  knowledge,
  physical;

  String get displayName {
    switch (this) {
      case DeedCategory.tongue:
        return 'Tongue';
      case DeedCategory.action:
        return 'Action';
      case DeedCategory.knowledge:
        return 'Knowledge';
      case DeedCategory.physical:
        return 'Physical';
    }
  }

  int get iconCodePoint {
    switch (this) {
      case DeedCategory.tongue:
        return 0xe0b0; // chat bubble
      case DeedCategory.action:
        return 0xe8e8; // volunteer_activism
      case DeedCategory.knowledge:
        return 0xe865; // menu_book
      case DeedCategory.physical:
        return 0xea3b; // self_improvement
    }
  }
}

class DeedCategoryAdapter extends TypeAdapter<DeedCategory> {
  @override
  final int typeId = 0;

  @override
  DeedCategory read(BinaryReader reader) {
    final index = reader.readInt();
    return DeedCategory.values[index];
  }

  @override
  void write(BinaryWriter writer, DeedCategory obj) {
    writer.writeInt(obj.index);
  }
}
