import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:mobwear/database/settings_database.dart';
import 'package:mobwear/utils/constants.dart';

class ThemeProvider with ChangeNotifier {
  static String themeIndexKey = SettingsDatabase.themeIndexKey;
  static Box settingsBox = SettingsDatabase.settingsBox;
  static int themeIndex = settingsBox.get(themeIndexKey) ?? 2;

  static Map<String, ThemeMode> myThemes = {
    'White': ThemeMode.light,
    'Black': ThemeMode.dark,
    'System': ThemeMode.system,
  };

  ThemeMode get getThemeMode => myThemes.values.elementAt(themeIndex);

  void changeTheme(BuildContext context, int i) {
    themeIndex = i;
    settingsBox.put(themeIndexKey, i);
    notifyListeners();
  }

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    accentColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          fontFamily: 'Righteous',
          fontSize: 26.0,
          color: Colors.black,
        ),
      ),
      color: Colors.white,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0.0,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      elevation: 10.0,
      titleTextStyle: kTitleTextStyle.copyWith(fontSize: 18.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.black12,
      selectionHandleColor: Colors.black,
      cursorColor: Colors.black,
    ),
    textTheme: TextTheme(
      headline5: TextStyle(
        fontFamily: 'Quicksand',
      ),
      headline6: TextStyle(
        fontFamily: 'Quicksand',
      ),
      caption: TextStyle(
        fontFamily: 'Quicksand',
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          fontFamily: 'Righteous',
          fontSize: 26.0,
          color: Colors.white,
        ),
      ),
      color: Colors.black,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      elevation: 0.0,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      titleTextStyle: kTitleTextStyle.copyWith(fontSize: 18.0),
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.white12,
      selectionHandleColor: Colors.white,
      cursorColor: Colors.white,
    ),
    textTheme: TextTheme(
      headline5: TextStyle(
        fontFamily: 'Quicksand',
      ),
      headline6: TextStyle(
        fontFamily: 'Quicksand',
      ),
      caption: TextStyle(
        fontFamily: 'Quicksand',
      ),
    ),
  );
}
