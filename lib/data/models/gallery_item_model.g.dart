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
      phoneName: fields[2] as String,
      phoneBrand: fields[3] as String,
      isFavorite: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GalleryDatabaseItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.imageString)
      ..writeByte(1)
      ..write(obj.imageDateTime)
      ..writeByte(2)
      ..write(obj.phoneName)
      ..writeByte(3)
      ..write(obj.phoneBrand)
      ..writeByte(4)
      ..write(obj.isFavorite);
  }
}
