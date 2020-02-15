import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobwear/theme/dynamic_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PhoneGroupView { grid, carousel }

Map<String, PhoneGroupView> myPhoneGroupViews = {
  'Carousel': PhoneGroupView.carousel,
  'Grid': PhoneGroupView.grid,
};

Map<String, bool> myAutoplayOptions = {
  'Autoplay carousel': true,
  'Keep carousel stagnant': false,
};

Map<String, Brightness> myThemes = {
  'White': Brightness.light,
  'Black': Brightness.dark,
};

class SettingsProvider extends ChangeNotifier {
  //Theme Settings
  static const String _brightnessKey = 'brightness_key';

  void changeBrightness(BuildContext context, Brightness brightness) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(
        _brightnessKey, brightness == Brightness.light ? false : true);

    DynamicTheme.of(context).setBrightness(brightness);
    DynamicTheme.of(context).setAccentColor(
      brightness == Brightness.light ? Colors.black : Colors.white,
    );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:
          brightness == Brightness.light ? Colors.white : Colors.black,
      systemNavigationBarIconBrightness:
          brightness == Brightness.light ? Brightness.dark : Brightness.light,
    ));
  }

  //Phone Group View Settings
  PhoneGroupView phoneGroupView;
  static const String _groupViewKey = 'group_view_key';

  Future<PhoneGroupView> loadPhoneGroupView() async {
    final prefs = await SharedPreferences.getInstance();
    int i = prefs.getInt(_groupViewKey) ?? 0;
    phoneGroupView = myPhoneGroupViews.values.elementAt(i);
    return phoneGroupView;
  }

  void changePhoneGroupView(PhoneGroupView selectedPhoneGroupView) async {
    phoneGroupView = selectedPhoneGroupView;

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_groupViewKey, phoneGroupView == PhoneGroupView.grid ? 1 : 0);

    notifyListeners();
  }

  //Carousel Autoplay Settings
  bool autoplayCarousel;
  static const String _carouselAutoplayKey = 'carousel_autoplay_key';

  Future<bool> loadAutoPlay() async {
    final prefs = await SharedPreferences.getInstance();
    bool b = prefs.getBool(_carouselAutoplayKey) ?? true;
    autoplayCarousel = b;
    return autoplayCarousel;
  }

  void changeAutoPlay(bool b) async {
    autoplayCarousel = b;

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_carouselAutoplayKey, autoplayCarousel);

    notifyListeners();
  }
}
