import 'package:hive/hive.dart';

class GalleryDatabase {
  static const String gallery = 'gallery';

  static var galleryBox = Hive.box(gallery);

  static Future<dynamic> initGalleryDB(Box galleryBox) async {
    if (galleryBox.isEmpty) {
      print('initializing gallery database');
    }
  }
}
