import 'package:hive/hive.dart';

class SettingsDatabase {
  static const String settings = 'settings';
  static const String initLaunchKey = 'initLaunchKey';
  static const String groupViewKey = 'groupViewKey';
  static const String editPageTipsKey = 'editPageTipsKey';
  static const String picPageTipsKey = 'picPageTipsKey';
  static const String themeIndexKey = 'themeIndexKey';
  static const String carouselAutoplayKey = 'carouselAutoplayKey';

  static var settingsBox = Hive.box(settings);

  static Future<dynamic> initSettingsDB(Box settingsBox) async {
    if (settingsBox.isEmpty) {
      print('initializing settings database');
      settingsBox.put(initLaunchKey, 0);
      settingsBox.put(groupViewKey, 0);
      settingsBox.put(editPageTipsKey, 0);
      settingsBox.put(picPageTipsKey, 0);
      settingsBox.put(themeIndexKey, 2);
      settingsBox.put(carouselAutoplayKey, true);
    }
  }
}
