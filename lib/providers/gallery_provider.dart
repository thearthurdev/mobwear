import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobwear/data/models/gallery_item_model.dart';
import 'package:mobwear/database/gallery_database.dart';

class GalleryProvider extends ChangeNotifier {
  Box galleryBox = Hive.box(GalleryDatabase.gallery);
  List<GalleryItem> galleryItems = [];
}
