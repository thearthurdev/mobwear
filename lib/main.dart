import 'package:flutter/material.dart';
import 'package:mobware/providers/phones_customization_provider.dart';
import 'package:mobware/providers/share_phone_page_provider.dart';
import 'package:mobware/providers/theme_provider.dart';
import 'package:mobware/theme/theme_data.dart';
import 'package:provider/provider.dart';

void main() => runApp(MobWare());

class MobWare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PhoneCustomizationProvider>(
            create: (context) => PhoneCustomizationProvider()),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
        ChangeNotifierProvider<SharePhonePageProvider>(
            create: (context) => SharePhonePageProvider()),
      ],
      child: MyThemeData(),
    );
  }
}
