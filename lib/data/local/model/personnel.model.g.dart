// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personnel.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonnelModelAdapter extends TypeAdapter<PersonnelModel> {
  @override
  final int typeId = 10;

  @override
  PersonnelModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonnelModel(
      name: fields[100] as String?,
      surname: fields[101] as String?,
      email: fields[102] as String,
      cellphone: fields[103] as String?,
      ratings: (fields[104] as List?)?.cast<Rating?>(),
      rank: fields[105] as String?,
      position: fields[106] as String?,
      token: fields[107] as String?,
      password: fields[108] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersonnelModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(100)
      ..write(obj.name)
      ..writeByte(101)
      ..write(obj.surname)
      ..writeByte(102)
      ..write(obj.email)
      ..writeByte(103)
      ..write(obj.cellphone)
      ..writeByte(104)
      ..write(obj.ratings)
      ..writeByte(105)
      ..write(obj.rank)
      ..writeByte(106)
      ..write(obj.position)
      ..writeByte(107)
      ..write(obj.token)
      ..writeByte(108)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonnelModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
