import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/providers/settings_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:provider/provider.dart';

class ThemePickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Theme',
            style: kTitleTextStyle.copyWith(fontSize: 18.0),
          ),
        ],
      ),
      children: <Widget>[
        Container(
          width: kDeviceWidth(context) - 200,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: myThemes.length,
            itemBuilder: (context, i) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                title: Text(myThemes.keys.elementAt(i)),
                trailing:
                    kThemeBrightness(context) == myThemes.values.elementAt(i)
                        ? Icon(
                            LineAwesomeIcons.check_circle,
                            color: kBrightnessAwareColor(context,
                                lightColor: Colors.black,
                                darkColor: Colors.white),
                          )
                        : null,
                onTap: () {
                  Navigator.pop(context);
                  Provider.of<SettingsProvider>(context).changeBrightness(
                    context,
                    myThemes.values.elementAt(i),
                  );
                },
              );
            },
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.end,
          buttonTextTheme: ButtonTextTheme.normal,
          children: <Widget>[
            FlatButton(
              child: Text('Cancel', style: kTitleTextStyle),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ],
    );
  }
}
