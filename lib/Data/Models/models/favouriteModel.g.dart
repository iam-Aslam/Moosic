// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favouriteModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class favouritesAdapter extends TypeAdapter<favouritesmodel> {
  @override
  final int typeId = 1;

  @override
  favouritesmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return favouritesmodel(
      id: fields[0] as int?,
      songname: fields[1] as String?,
      artist: fields[2] as String?,
      duration: fields[3] as int?,
      songurl: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, favouritesmodel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.songname)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.songurl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is favouritesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
