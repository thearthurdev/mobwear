import 'package:hive/hive.dart';

class SettingsDatabase {
  static const String settings = 'settings';
  static const String themeIndexKey = 'themeIndexKey';
  static const String groupViewKey = 'groupViewKey';
  static const String carouselAutoplayKey = 'carouselAutoplayKey';

  static var settingsBox = Hive.box(settings);

  static Future<dynamic> initSettingsDB(Box settingsBox) async {
    if (settingsBox.isEmpty) {
      print('initializing settings database');
      settingsBox.put(themeIndexKey, 2);
      settingsBox.put(groupViewKey, 0);
      settingsBox.put(carouselAutoplayKey, true);
    }
  }
}
