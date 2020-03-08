// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GalleryDatabaseItemAdapter extends TypeAdapter<GalleryDatabaseItem> {
  @override
  final typeId = 3;

  @override
  GalleryDatabaseItem read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GalleryDatabaseItem(
      imageString: fields[0] as String,
      imageDateTime: fields[1] as String,
      imageFileName: fields[2] as String,
      phoneName: fields[3] as String,
      phoneBrand: fields[4] as String,
      isFavorite: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GalleryDatabaseItem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.imageString)
      ..writeByte(1)
      ..write(obj.imageDateTime)
      ..writeByte(2)
      ..write(obj.imageFileName)
      ..writeByte(3)
      ..write(obj.phoneName)
      ..writeByte(4)
      ..write(obj.phoneBrand)
      ..writeByte(5)
      ..write(obj.isFavorite);
  }
}
