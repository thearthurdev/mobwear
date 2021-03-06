import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobwear/data/models/gallery_item_model.dart';
import 'package:mobwear/database/gallery_database.dart';

class GalleryProvider extends ChangeNotifier {
  Box galleryBox = GalleryDatabase.galleryBox;
  List<GalleryItem> galleryItems = [];
  int currentIndex;

  void setCurrentIndex(int i) => currentIndex = i;

  Future<void> loadGallery() async {
    galleryItems = List.generate(galleryBox.values.length, (i) {
      GalleryDatabaseItem databaseItem = galleryBox.getAt(i);

      return GalleryItem(
        imageBytes: Uint8List.fromList(databaseItem.imageString.codeUnits),
        imageDateTime: databaseItem.imageDateTime,
        imageFileName: databaseItem.imageFileName,
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
        imageFileName: item.imageFileName,
        phoneName: item.phoneName,
        phoneBrand: item.phoneBrand,
        isFavorite: !item.isFavorite,
      ),
    );

    galleryItems[i] = GalleryItem(
      imageBytes: item.imageBytes,
      imageDateTime: item.imageDateTime,
      imageFileName: item.imageFileName,
      phoneName: item.phoneName,
      phoneBrand: item.phoneBrand,
      isFavorite: !item.isFavorite,
    );

    notifyListeners();
  }

  void deleteItem(String itemKey) {
    try {
      for (int i = 0; i != galleryBox.values.length; i++) {
        if (itemKey == galleryBox.getAt(i).imageFileName) {
          galleryBox.deleteAt(i);
          galleryItems.removeAt(i);

          if (currentIndex == galleryBox.values.length && currentIndex != 0) {
            currentIndex--;
          }

          notifyListeners();
        }
      }
    } catch (e) {}
  }

  Future<void> deleteBatchItems(List<String> itemKeys) async {
    try {
      for (String key in itemKeys) {
        for (int i = 0; i != galleryBox.values.length; i++) {
          if (key == galleryBox.getAt(i).imageFileName) {
            galleryBox.deleteAt(i);
            galleryItems.removeAt(i);
            notifyListeners();
          }
        }
      }
    } catch (e) {}
  }
}
