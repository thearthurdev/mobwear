import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobwear/data/adapters/color_adapter.dart';
import 'package:mobwear/data/models/gallery_item_model.dart';
import 'package:mobwear/data/models/phone_data_model.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:mobwear/database/gallery_database.dart';
import 'package:mobwear/database/phone_database.dart';
import 'package:mobwear/database/settings_database.dart';
import 'package:mobwear/pages/about_page.dart';
import 'package:mobwear/pages/edit_phone_page.dart';
import 'package:mobwear/pages/gallery_page.dart';
import 'package:mobwear/pages/gallery_view_page.dart';
import 'package:mobwear/pages/home_page.dart';
import 'package:mobwear/pages/onboarding_page.dart';
import 'package:mobwear/pages/settings_page.dart';
import 'package:mobwear/pages/picture_mode_page.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/providers/gallery_provider.dart';
import 'package:mobwear/providers/settings_provider.dart';
import 'package:mobwear/providers/theme_provider.dart';
import 'package:mobwear/services/scroll_behaviour.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);
  // Note: Highest typeAdapter typeId = 3
  Hive.registerAdapter(PhoneDataModelAdapter());
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(MyTextureAdapter());
  Hive.registerAdapter(GalleryDatabaseItemAdapter());

  Future<void> openBoxes() async {
    Box settingsBox = await Hive.openBox(SettingsDatabase.settings);
    SettingsDatabase.initSettingsDB(settingsBox);

    Box phonesBox = await Hive.openBox(PhoneDatabase.phones);
    PhoneDatabase.initPhonesDB(phonesBox);

    Box galleryBox = await Hive.openBox(GalleryDatabase.gallery);
    GalleryDatabase.initGalleryDB(galleryBox);
  }

  openBoxes().whenComplete(
    () => runApp(
      // DevicePreview(
      // builder: (context) => MultiProvider(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<CustomizationProvider>(
              create: (context) => CustomizationProvider()),
          ChangeNotifierProvider<SettingsProvider>(
              create: (context) => SettingsProvider()),
          ChangeNotifierProvider<ThemeProvider>(
              create: (context) => ThemeProvider()),
          ChangeNotifierProvider<GalleryProvider>(
              create: (context) => GalleryProvider()),
        ],
        child: MobWear(),
      ),
    ),
    // ),
  );
}

class MobWear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Box settingsBox = SettingsDatabase.settingsBox;
    bool isFirstLaunch = settingsBox.get(SettingsDatabase.initLaunchKey) == 0;

    return MaterialApp(
      title: 'MobWear',
      themeMode: Provider.of<ThemeProvider>(context).getThemeMode,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeProvider.lightTheme,
      darkTheme: ThemeProvider.darkTheme,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyScrollBehavior(),
          child: child,
        );
      },
      // builder: DevicePreview.appBuilder,
      // locale: DevicePreview.of(context).locale,
      home: isFirstLaunch ? OnboardingPage() : HomePage(),
      routes: {
        SettingsPage.id: (context) => SettingsPage(),
        EditPhonePage.id: (context) => EditPhonePage(),
        PictureModePage.id: (context) => PictureModePage(),
        AboutPage.id: (context) => AboutPage(),
        GalleryPage.id: (context) => GalleryPage(),
        GalleryViewPage.id: (context) => GalleryViewPage(),
      },
    );
  }
}
