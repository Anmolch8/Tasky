// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class dataAdapter extends TypeAdapter<data> {
  @override
  final int typeId = 0;

  @override
  data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return data(
      title: fields[0] as String,
      detail: fields[1] as String,
      iscompleted: fields[2] as bool?,
      timestamp: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, data obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.detail)
      ..writeByte(2)
      ..write(obj.iscompleted)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is dataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
