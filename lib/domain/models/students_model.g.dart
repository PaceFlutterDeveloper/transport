// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 0;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      studCode: fields[0] as String,
      studName: fields[1] as String,
      grade: fields[2] as String,
      nfcTag: fields[3] as String,
      lastAttendance: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.studCode)
      ..writeByte(1)
      ..write(obj.studName)
      ..writeByte(2)
      ..write(obj.grade)
      ..writeByte(3)
      ..write(obj.nfcTag)
      ..writeByte(4)
      ..write(obj.lastAttendance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
