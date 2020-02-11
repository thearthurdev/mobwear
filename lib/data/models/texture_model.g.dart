// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'texture_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyTextureAdapter extends TypeAdapter<MyTexture> {
  @override
  final typeId = 1;

  @override
  MyTexture read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyTexture(
      name: fields[0] as String,
      asset: fields[1] as String,
      blendColor: fields[2] as Color,
      blendModeIndex: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MyTexture obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.asset)
      ..writeByte(2)
      ..write(obj.blendColor)
      ..writeByte(3)
      ..write(obj.blendModeIndex);
  }
}
