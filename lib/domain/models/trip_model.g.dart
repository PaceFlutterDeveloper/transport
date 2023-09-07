// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripModelAdapter extends TypeAdapter<TripModel> {
  @override
  final int typeId = 1;

  @override
  TripModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripModel(
      tripId: fields[0] as String,
      id: fields[1] as int,
      nfcTag: fields[2] as String,
      studCode: fields[3] as String,
      entryTime: fields[4] as String,
      exitTime: fields[5] as String,
      entryStat: fields[6] as String,
      exitStat: fields[7] as String,
      entryLat: fields[8] as double,
      entryLong: fields[9] as double,
      exitLat: fields[10] as double,
      exitLong: fields[11] as double,
      lastUpdated: fields[13] as DateTime,
      name: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TripModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.tripId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.nfcTag)
      ..writeByte(3)
      ..write(obj.studCode)
      ..writeByte(4)
      ..write(obj.entryTime)
      ..writeByte(5)
      ..write(obj.exitTime)
      ..writeByte(6)
      ..write(obj.entryStat)
      ..writeByte(7)
      ..write(obj.exitStat)
      ..writeByte(8)
      ..write(obj.entryLat)
      ..writeByte(9)
      ..write(obj.entryLong)
      ..writeByte(10)
      ..write(obj.exitLat)
      ..writeByte(11)
      ..write(obj.exitLong)
      ..writeByte(12)
      ..write(obj.name)
      ..writeByte(13)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
