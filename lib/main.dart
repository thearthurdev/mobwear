import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobwear/data/adapters/color_adapter.dart';
import 'package:mobwear/data/models/phone_data_model.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:mobwear/database/phone_database.dart';
import 'package:mobwear/database/settings_database.dart';
import 'package:mobwear/pages/about_page.dart';
import 'package:mobwear/pages/edit_phone_page.dart';
import 'package:mobwear/pages/home_page.dart';
import 'package:mobwear/pages/settings_page.dart';
import 'package:mobwear/pages/share_phone_Page.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/providers/settings_provider.dart';
import 'package:mobwear/providers/theme_provider.dart';
import 'package:mobwear/services/scroll_behaviour.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

// void main() => runApp(
//       DevicePreview(
//         builder: (context) => MobWear(),
//       ),
//     );
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(PhoneDataModelAdapter());
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(MyTextureAdapter());

  Future<void> openBoxes() async {
    Box settingsBox = await Hive.openBox(SettingsDatabase.settings);
    SettingsDatabase.initSettingsDB(settingsBox);

    Box phonesBox = await Hive.openBox(PhoneDatabase.phones);
    PhoneDatabase.initPhonesDB(phonesBox);
  }

  openBoxes().whenComplete(
    () => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<CustomizationProvider>(
              create: (context) => CustomizationProvider()),
          ChangeNotifierProvider<SettingsProvider>(
              create: (context) => SettingsProvider()),
          ChangeNotifierProvider<ThemeProvider>(
              create: (context) => ThemeProvider()),
        ],
        child: MobWear(),
      ),
    ),
  );
}

class MobWear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobWear',
      themeMode: Provider.of<ThemeProvider>(context).getThemeMode,
      theme: ThemeProvider.lightTheme,
      darkTheme: ThemeProvider.darkTheme,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyScrollBehavior(),
          child: child,
        );
      },
      // locale: DevicePreview.of(context).locale,
      // builder: DevicePreview.appBuilder,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      routes: {
        SettingsPage.id: (context) => SettingsPage(),
        EditPhonePage.id: (context) => EditPhonePage(),
        SharePhonePage.id: (context) => SharePhonePage(),
        AboutPage.id: (context) => AboutPage(),
      },
    );
  }
}
