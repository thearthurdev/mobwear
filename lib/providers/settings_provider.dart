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

enum RateAppStatus { yet, done, never }

class SettingsProvider extends ChangeNotifier {
  Box settingsBox = SettingsDatabase.settingsBox;

  //App Rating Settings
  RateAppStatus rateAppStatus;
  String rateAppKey = SettingsDatabase.rateAppKey;

  Future<RateAppStatus> getRateAppStatus() async {
    int i = settingsBox.get(rateAppKey) ?? 0;
    rateAppStatus = RateAppStatus.values.elementAt(i);
    return rateAppStatus;
  }

  void changeRateAppStatus(int i) async {
    rateAppStatus = RateAppStatus.values.elementAt(i);
    settingsBox.put(rateAppKey, i);
    notifyListeners();
  }

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
  bool autoPlayCarousel;
  bool tabIsSwiping = false;
  String carouselAutoplayKey = SettingsDatabase.carouselAutoplayKey;

  Future<bool> loadAutoPlay() async {
    bool b = settingsBox.get(carouselAutoplayKey) ?? true;
    autoPlayCarousel = b;
    return autoPlayCarousel;
  }

  void changeAutoPlay(bool b) async {
    autoPlayCarousel = b;
    settingsBox.put(carouselAutoplayKey, autoPlayCarousel);
    notifyListeners();
  }

  void changeTabSwipingStatus(bool b) {
    tabIsSwiping = b;
    notifyListeners();
  }
}
