import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/adaptiveDialog.dart';

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
      child: AdaptiveDialog(
        title: 'Developer Info',
        hasSelectButton: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 140.0,
                width: kDeviceWidth(context),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/arthurdev_logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
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
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: kTitleTextStyle,
      ),
    );
  }
}
