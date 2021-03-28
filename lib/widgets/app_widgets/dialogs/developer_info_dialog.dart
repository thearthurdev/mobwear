import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/dialogs/adaptive_dialog.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<IconData, String> infoSections = {
      LineAwesomeIcons.globe: 'thearthur.dev',
      LineAwesomeIcons.github: 'github.com/thearthurdev',
      LineAwesomeIcons.linkedin: 'linkedin.com/in/arthurdelords',
      LineAwesomeIcons.envelope_square: 'arthurdelords@gmail.com',
      LineAwesomeIcons.twitter: '@_DeeArthur',
    };

    void launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        // throw 'Could not launch $url';
        Toast.show(
          'Couldn\'t open $url\nPlease try again later',
          context,
          duration: 2,
          backgroundColor: kBrightnessAwareColor(context,
              lightColor: Colors.black87, darkColor: Colors.white70),
          textColor: kBrightnessAwareColor(context,
              lightColor: Colors.white, darkColor: Colors.black),
          backgroundRadius: 10.0,
          gravity: 0,
        );
      }
    }

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
          child: Scrollbar(
            child: SingleChildScrollView(
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
                          lightColor: Colors.grey[100],
                          darkColor: Colors.black26),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        infoListTile(
                          context,
                          icon: infoSections.keys.elementAt(0),
                          title: infoSections.values.elementAt(0),
                          onTap: () => launchURL(
                              'https:${infoSections.values.elementAt(0)}'),
                        ),
                        infoListTile(
                          context,
                          icon: infoSections.keys.elementAt(1),
                          title: infoSections.values.elementAt(1),
                          onTap: () => launchURL(
                              'https:${infoSections.values.elementAt(1)}'),
                        ),
                        infoListTile(
                          context,
                          icon: infoSections.keys.elementAt(2),
                          title: infoSections.values.elementAt(2),
                          onTap: () => launchURL(
                              'https:${infoSections.values.elementAt(2)}'),
                        ),
                        infoListTile(
                          context,
                          icon: infoSections.keys.elementAt(3),
                          title: infoSections.values.elementAt(3),
                          onTap: () => launchURL(
                              'mailto:${infoSections.values.elementAt(3)}?subject=MobWear&body=Dear%20Delords,'),
                        ),
                        infoListTile(
                          context,
                          icon: infoSections.keys.elementAt(4),
                          title: infoSections.values.elementAt(4),
                          onTap: () => launchURL(
                              'https:twitter.com/${infoSections.values.elementAt(4).split("@")[1]}'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListTile infoListTile(BuildContext context,
      {IconData icon, String title, Function onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: kBrightnessAwareColor(context,
            lightColor: Colors.black, darkColor: Colors.white),
      ),
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: kTitleTextStyle.copyWith(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
      onTap: onTap,
    );
  }
}
