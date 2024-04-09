// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemDatabaseAdapter extends TypeAdapter<ItemDatabase> {
  @override
  final int typeId = 0;

  @override
  ItemDatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemDatabase(
      img: fields[2] as String,
      time: fields[1] as int,
      title: fields[0] as String,
      id: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ItemDatabase obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.img)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemDatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
