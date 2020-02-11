// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhoneDataModelAdapter extends TypeAdapter<PhoneDataModel> {
  @override
  final typeId = 0;

  @override
  PhoneDataModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhoneDataModel(
      id: fields[0] as int,
      colors: (fields[1] as Map)?.cast<String, Color>(),
      textures: (fields[2] as Map)?.cast<String, MyTexture>(),
    );
  }

  @override
  void write(BinaryWriter writer, PhoneDataModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.colors)
      ..writeByte(2)
      ..write(obj.textures);
  }
}
