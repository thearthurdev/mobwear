import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobwear/data/adapters/color_adapter.dart';
import 'package:mobwear/data/models/phone_data_model.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:mobwear/database/phone_database.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/providers/settings_provider.dart';
import 'package:mobwear/theme/theme_data.dart';
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

  var phonesBox = await Hive.openBox(PhoneDatabase.phones);

  PhoneDatabase.initPhonesDB(phonesBox).whenComplete(() => runApp(MobWear()));
}

class MobWear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CustomizationProvider>(
            create: (context) => CustomizationProvider()),
        ChangeNotifierProvider<SettingsProvider>(
            create: (context) => SettingsProvider()),
      ],
      child: MyThemeData(),
    );
  }
}
