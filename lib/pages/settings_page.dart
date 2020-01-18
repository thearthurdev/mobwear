import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/providers/theme_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static final String id = 'SettingsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(LineAwesomeIcons.angle_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'Theme',
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                letterSpacing: 0.3,
              ),
            ),
            subtitle: Text(
              'Select a theme',
              style: TextStyle(
                fontFamily: 'Quicksand',
                color: kBrightnessAwareColor(context,
                    lightColor: Colors.black54, darkColor: Colors.white54),
              ),
            ),
          ),
          selectBrightnessTile(
            context,
            'White',
            Brightness.light,
          ),
          selectBrightnessTile(
            context,
            'Black',
            Brightness.dark,
          ),
        ],
      ),
    );
  }

  Widget selectBrightnessTile(
      BuildContext context, String title, Brightness brightness) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          trailing: kThemeBrightness(context) == brightness
              ? Icon(
                  LineAwesomeIcons.check_circle,
                  color: kBrightnessAwareColor(context,
                      lightColor: Colors.black, darkColor: Colors.white),
                )
              : null,
          onTap: () {
            Provider.of<ThemeProvider>(context)
                .changeBrightness(context, brightness);
          },
        ),
        Divider(indent: 16.0),
      ],
    );
  }
}
