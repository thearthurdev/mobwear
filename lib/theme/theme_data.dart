import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobware/pages/edit_phone_page.dart';
import 'package:mobware/pages/settings_page.dart';
import 'package:mobware/theme/dynamic_theme.dart';

class MyThemeData extends StatelessWidget {
  final Widget home;
  MyThemeData({@required this.home});

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultAccentColor: Colors.deepOrange,
        defaultBrightness: Brightness.dark,
        data: (accentColor, brightness) => ThemeData(
              accentColor: accentColor,
              brightness: brightness,
              scaffoldBackgroundColor:
                  brightness == Brightness.light ? Colors.white : Colors.black,
              appBarTheme: AppBarTheme(
                textTheme: TextTheme(
                  title: Theme.of(context).textTheme.title.copyWith(
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
              buttonTheme: ButtonThemeData(
                buttonColor: accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              textTheme: TextTheme(
                body2: Theme.of(context).textTheme.body1.copyWith(
                      color: accentColor.computeLuminance() > 0.335
                          ? Colors.black
                          : Colors.white,
                    ),
              ),
            ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            title: 'mobware.',
            theme: theme,
            home: home,
            debugShowCheckedModeBanner: false,
            debugShowMaterialGrid: false,
            routes: {
              SettingsPage.id: (context) => SettingsPage(),
              EditPhonePage.id: (context) => EditPhonePage(),
            },
          );
        });
  }
}
