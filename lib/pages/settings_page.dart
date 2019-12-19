import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:mobware/providers/theme_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static final String id = 'SettingsPage';

  @override
  Widget build(BuildContext context) {
    ListTile selectColorTile({
      String title,
    }) {
      return ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('Select an ${title.toLowerCase()}'),
        trailing: CircleColor(
          circleSize: 50.0,
          color: title.contains('Primary')
              ? kPrimaryColor(context)
              : kAccentColor(context),
        ),
        onTap: () {
          Provider.of<ThemeProvider>(context)
              .changeAccentColor(context, kAccentColor(context));
        },
      );
    }

    ListTile selectBrightnessTile(String title, Brightness brightness) {
      return ListTile(
        title: Text(title),
        trailing: kThemeBrightness(context) == brightness
            ? Icon(
                LineAwesomeIcons.check_circle,
                color: kAccentColor(context),
              )
            : SizedBox(),
        onTap: () {
          Provider.of<ThemeProvider>(context)
              .changeBrightness(context, brightness);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Settings'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(LineAwesomeIcons.angle_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            selectColorTile(title: 'Accent Color'),
            SizedBox(height: 20.0),
            ListTile(
              title: Text(
                'Theme',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Select theme'),
            ),
            selectBrightnessTile('Light', Brightness.light),
            Divider(indent: 16.0),
            selectBrightnessTile('Black', Brightness.dark),
            Divider(indent: 16.0),
          ],
        ),
      ),
    );
  }
}
