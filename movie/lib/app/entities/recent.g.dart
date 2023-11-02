// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentAdapter extends TypeAdapter<Recent> {
  @override
  final int typeId = 2;

  @override
  Recent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recent(
      item: fields[0] as String,
      dateTime: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Recent obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.item)
      ..writeByte(1)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
