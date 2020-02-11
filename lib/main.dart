import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobware/data/adapters/color_adapter.dart';
import 'package:mobware/data/models/phone_data_model.dart';
import 'package:mobware/data/models/texture_model.dart';
import 'package:mobware/database/phone_database.dart';
import 'package:mobware/providers/customization_provider.dart';
import 'package:mobware/providers/settings_provider.dart';
import 'package:mobware/theme/theme_data.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

// void main() => runApp(
//       DevicePreview(
//         builder: (context) => MobWare(),
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

  PhoneDatabase.initPhonesDB(phonesBox).whenComplete(() => runApp(MobWare()));
}

class MobWare extends StatelessWidget {
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
