import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:mobware/theme/dynamic_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _accentColorKey = 'my_accent_key';
  static const String _brightnessKey = 'my_brightness_key';

  void changeBrightness(BuildContext context, Brightness brightness) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(
        _brightnessKey, brightness == Brightness.light ? false : true);

    DynamicTheme.of(context).setBrightness(brightness);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:
          brightness == Brightness.light ? Colors.white : Colors.black,
      systemNavigationBarIconBrightness:
          brightness == Brightness.light ? Brightness.dark : Brightness.light,
    ));
  }

  void changeAccentColor(BuildContext context, Color _accentColor) {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text('Pick a color'),
        children: <Widget>[
          MaterialColorPicker(
            shrinkWrap: true,
            onColorChange: (Color color) {
              _accentColor = color;
            },
            selectedColor: _accentColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text('Select'),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString(_accentColorKey, '$_accentColor');

                  DynamicTheme.of(context).setAccentColor(_accentColor);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
