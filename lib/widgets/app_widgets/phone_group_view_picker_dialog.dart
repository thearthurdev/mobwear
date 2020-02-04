import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/providers/settings_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:provider/provider.dart';

class PhoneGroupViewPickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: EdgeInsets.fromLTRB(20.0, 16.0, 13.0, 0.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Phone Group View',
            style: kTitleTextStyle.copyWith(fontSize: 18.0),
          ),
          IconButton(
            icon: Icon(LineAwesomeIcons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      children: <Widget>[
        Container(
          width: kDeviceWidth(context) - 200,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: myPhoneGroupViews.length,
            itemBuilder: (context, i) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                title: Text(myPhoneGroupViews.keys.elementAt(i)),
                trailing:
                    Provider.of<SettingsProvider>(context).phoneGroupView ==
                            myPhoneGroupViews.values.elementAt(i)
                        ? Icon(
                            LineAwesomeIcons.check_circle,
                            color: kBrightnessAwareColor(context,
                                lightColor: Colors.black,
                                darkColor: Colors.white),
                          )
                        : null,
                onTap: () {
                  Navigator.pop(context);
                  Provider.of<SettingsProvider>(context).changePhoneGroupView(
                    myPhoneGroupViews.values.elementAt(i),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
