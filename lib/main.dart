import 'package:flutter/material.dart';
import 'package:mobware/providers/phones_data.dart';
import 'package:mobware/providers/theme_provider.dart';
import 'package:mobware/theme/theme_data.dart';
import 'package:provider/provider.dart';

void main() => runApp(MobWare());

class MobWare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PhonesData>(create: (context) => PhonesData()),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
      ],
      child: MyThemeData(),
    );
  }
}
