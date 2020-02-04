import 'package:flutter/material.dart';
import 'package:mobware/providers/customization_provider.dart';
import 'package:mobware/providers/settings_provider.dart';
import 'package:mobware/theme/theme_data.dart';
import 'package:provider/provider.dart';

// void main() => runApp(
//       DevicePreview(
//         builder: (context) => MobWare(),
//       ),
//     );
void main() => runApp(MobWare());

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
