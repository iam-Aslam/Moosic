// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mostplayed.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MostPlayedAdapter extends TypeAdapter<MostPlayed> {
  @override
  final int typeId = 4;

  @override
  MostPlayed read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MostPlayed(
      songname: fields[0] as String,
      songurl: fields[3] as String,
      duration: fields[2] as int,
      artist: fields[1] as String,
      count: fields[4] as int,
      id: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MostPlayed obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.songname)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.songurl)
      ..writeByte(4)
      ..write(obj.count)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MostPlayedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
