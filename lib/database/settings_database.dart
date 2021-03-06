import 'package:hive/hive.dart';

class SettingsDatabase {
  static const String settings = 'settings';
  static const String rateAppKey = 'rateAppKey';
  static const String groupViewKey = 'groupViewKey';
  static const String initLaunchKey = 'initLaunchKey';
  static const String launchCountKey = 'launchCountKey';
  static const String themeIndexKey = 'themeIndexKey';
  static const String carouselAutoplayKey = 'carouselAutoplayKey';

  //Onboarding tip Keys
  static const String flipPhoneTipKey = 'flipPhoneTipKey';
  static const String swipeCardTipKey = 'swipeCardTipKey';
  static const String movePhoneTipKey = 'movePhoneTipKey';

  static var settingsBox = Hive.box(settings);

  static Future<dynamic> initSettingsDB(Box settingsBox) async {
    if (settingsBox.isEmpty) {
      print('initializing settings database');
      settingsBox.put(rateAppKey, 0);
      settingsBox.put(groupViewKey, 0);
      settingsBox.put(initLaunchKey, 0);
      settingsBox.put(launchCountKey, 0);
      settingsBox.put(themeIndexKey, 2);
      settingsBox.put(carouselAutoplayKey, true);

      //init tip keys
      settingsBox.put(flipPhoneTipKey, 0);
      settingsBox.put(swipeCardTipKey, 0);
      settingsBox.put(movePhoneTipKey, 0);
    }

    //Launch counter
    settingsBox.put(launchCountKey, settingsBox.get(launchCountKey) + 1);
    // print('Launch Count: ${settingsBox.get(launchCountKey)}');
  }
}
