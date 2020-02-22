import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobwear/database/settings_database.dart';

enum PhoneGroupView { grid, carousel }

Map<String, PhoneGroupView> myPhoneGroupViews = {
  'Carousel': PhoneGroupView.carousel,
  'Grid': PhoneGroupView.grid,
};

Map<String, bool> myAutoplayOptions = {
  'Autoplay carousel': true,
  'Keep carousel stagnant': false,
};

class SettingsProvider extends ChangeNotifier {
  Box settingsBox = Hive.box(SettingsDatabase.settings);

  //Phone Group View Settings
  PhoneGroupView phoneGroupView;
  String groupViewKey = SettingsDatabase.groupViewKey;

  Future<PhoneGroupView> loadPhoneGroupView() async {
    int i = settingsBox.get(groupViewKey) ?? 0;
    phoneGroupView = myPhoneGroupViews.values.elementAt(i);
    return phoneGroupView;
  }

  void changePhoneGroupView(PhoneGroupView selectedPhoneGroupView) async {
    phoneGroupView = selectedPhoneGroupView;
    int groupViewIndex = phoneGroupView == PhoneGroupView.grid ? 1 : 0;
    settingsBox.put(groupViewKey, groupViewIndex);
    notifyListeners();
  }

  //Carousel Autoplay Settings
  bool autoplayCarousel;
  String carouselAutoplayKey = SettingsDatabase.carouselAutoplayKey;

  Future<bool> loadAutoPlay() async {
    bool b = settingsBox.get(carouselAutoplayKey) ?? true;
    autoplayCarousel = b;
    return autoplayCarousel;
  }

  void changeAutoPlay(bool b) async {
    autoplayCarousel = b;
    settingsBox.put(carouselAutoplayKey, autoplayCarousel);
    notifyListeners();
  }
}