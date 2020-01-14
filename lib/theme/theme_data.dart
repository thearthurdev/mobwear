import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobware/pages/edit_phone_page.dart';
import 'package:mobware/pages/home_page.dart';
import 'package:mobware/pages/settings_page.dart';
import 'package:mobware/pages/share_phone_Page.dart';
import 'package:mobware/services/scroll_behaviour.dart';
import 'package:mobware/theme/dynamic_theme.dart';

class MyThemeData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        defaultAccentColor: Colors.black,
        data: (accentColor, brightness) => ThemeData(
              accentColor:
                  brightness == Brightness.light ? Colors.black : Colors.white,
              brightness: brightness,
              scaffoldBackgroundColor:
                  brightness == Brightness.light ? Colors.white : Colors.black,
              appBarTheme: AppBarTheme(
                textTheme: TextTheme(
                  title: TextStyle(
                    fontFamily: 'Righteous',
                    fontSize: 26.0,
                    color: brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                color: brightness == Brightness.light
                    ? Colors.white
                    : Colors.black,
                brightness: brightness == Brightness.light
                    ? Brightness.light
                    : Brightness.dark,
                iconTheme: IconThemeData(
                  color: brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
                elevation: 0.0,
              ),
              textTheme: TextTheme(
                headline: TextStyle(
                  fontFamily: 'Quicksand',
                ),
                title: TextStyle(
                  fontFamily: 'Quicksand',
                ),
              ),
            ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            title: 'mobware.',
            theme: theme,
            builder: (context, child) {
              return ScrollConfiguration(
                behavior: MyScrollBehavior(),
                child: child,
              );
            },
            home: HomePage(),
            debugShowCheckedModeBanner: false,
            debugShowMaterialGrid: false,
            routes: {
              SettingsPage.id: (context) => SettingsPage(),
              EditPhonePage.id: (context) => EditPhonePage(),
              SharePhonePage.id: (context) => SharePhonePage(),
            },
          );
        });
  }
}
