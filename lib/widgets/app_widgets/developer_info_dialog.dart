import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/utils/constants.dart';

class DeveloperInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<IconData, String> infoSections = {
      LineAwesomeIcons.github: 'github.com/ArthurDevv',
      LineAwesomeIcons.linkedin: 'linkedin.com/in/arthurdelords',
      LineAwesomeIcons.envelope_square: 'arthurdelords@gmail.com',
      LineAwesomeIcons.twitter: '@_DeeArthur',
    };

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kBrightnessAwareColor(context,
            lightColor: Color(0xFF757575), darkColor: Colors.black),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 0.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Developer Info',
                      style: kTitleTextStyle.copyWith(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              Container(
                height: kScreenAwareSize(160.0, context),
                width: kDeviceWidth(context) - kScreenAwareSize(160.0, context),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/arthurdev_logo.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Text(
                'Delords Arthur',
                style: TextStyle(
                  fontFamily: 'Righteous',
                  fontSize: 22.0,
                ),
              ),
              Text('ArthurDev', style: kTitleTextStyle),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: kBrightnessAwareColor(context,
                      lightColor: Colors.grey[100], darkColor: Colors.black26),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(infoSections.length, (i) {
                    return infoListTile(
                      context,
                      icon: infoSections.keys.elementAt(i),
                      title: infoSections.values.elementAt(i),
                    );
                  }),
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
          ),
        ),
      ),
    );
  }

  ListTile infoListTile(BuildContext context, {IconData icon, String title}) {
    return ListTile(
      leading: Icon(
        icon,
        color: kBrightnessAwareColor(context,
            lightColor: Colors.black, darkColor: Colors.white),
      ),
      title: Text(title, style: kTitleTextStyle),
    );
  }
}
