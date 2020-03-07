import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobwear/data/models/gallery_item_model.dart';
import 'package:mobwear/database/gallery_database.dart';

class GalleryProvider extends ChangeNotifier {
  static Box galleryBox = Hive.box(GalleryDatabase.gallery);
  List<GalleryItem> galleryItems = [];

  Future<void> loadGallery() async {
    galleryItems = List.generate(galleryBox.values.length, (i) {
      GalleryDatabaseItem databaseItem = galleryBox.getAt(i);

      return GalleryItem(
        imageBytes: Uint8List.fromList(databaseItem.imageString.codeUnits),
        imageDateTime: databaseItem.imageDateTime,
        phoneName: databaseItem.phoneName,
        phoneBrand: databaseItem.phoneBrand,
        isFavorite: databaseItem.isFavorite,
      );
    });
  }

  void toggleItemFavStatus(int i) {
    GalleryItem item = galleryItems[i];
    galleryBox.putAt(
      i,
      GalleryDatabaseItem(
        imageString: String.fromCharCodes(item.imageBytes),
        imageDateTime: item.imageDateTime,
        phoneName: item.phoneName,
        phoneBrand: item.phoneBrand,
        isFavorite: !item.isFavorite,
      ),
    );

    galleryItems[i] = GalleryItem(
      imageBytes: item.imageBytes,
      imageDateTime: item.imageDateTime,
      phoneName: item.phoneName,
      phoneBrand: item.phoneBrand,
      isFavorite: !item.isFavorite,
    );

    notifyListeners();
  }

  void deleteItem(int i) {
    galleryBox.deleteAt(i);
    galleryItems.removeAt(i);
    notifyListeners();
  }
}
