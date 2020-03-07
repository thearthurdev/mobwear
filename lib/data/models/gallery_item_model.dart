import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'gallery_item_model.g.dart';

@HiveType(typeId: 3)
class GalleryDatabaseItem {
  @HiveField(0)
  final String imageString;
  @HiveField(1)
  final String imageDateTime;
  @HiveField(2)
  final String phoneName;
  @HiveField(3)
  final String phoneBrand;
  @HiveField(4)
  final bool isFavorite;

  GalleryDatabaseItem({
    this.imageString,
    this.imageDateTime,
    this.phoneName,
    this.phoneBrand,
    this.isFavorite,
  });
}

class GalleryItem {
  final Uint8List imageBytes;
  final String imageDateTime;
  final String phoneName;
  final String phoneBrand;
  final bool isFavorite;

  GalleryItem({
    this.imageBytes,
    this.imageDateTime,
    this.phoneName,
    this.phoneBrand,
    this.isFavorite,
  });
}
