import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/custom_icons/custom_icons.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/developer_info_dialog.dart';
import 'package:package_info/package_info.dart';
import 'package:device_id/device_id.dart';

class AboutPage extends StatelessWidget {
  static const String id = '/AboutPage';

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<String> getDeviceID() async {
    String deviceID = await DeviceId.getID;
    return deviceID;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kBrightnessAwareColor(context,
            lightColor: Colors.white, darkColor: Colors.black),
        systemNavigationBarIconBrightness:
            kThemeBrightness(context) == Brightness.light
                ? Brightness.dark
                : Brightness.light,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('About'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(LineAwesomeIcons.angle_left),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            // width: kDeviceWidth(context),
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 24.0),
                Container(
                  width: kScreenAwareSize(100.0, context),
                  height: kScreenAwareSize(100.0, context),
                  decoration: BoxDecoration(
                    color: kBrightnessAwareColor(context,
                        lightColor: Colors.black, darkColor: Colors.white),
                    borderRadius:
                        BorderRadius.circular(kScreenAwareSize(16.0, context)),
                  ),
                  child: Icon(
                    CustomIcons.mobwear,
                    color: kBrightnessAwareColor(context,
                        lightColor: Colors.white, darkColor: Colors.black),
                    size: kScreenAwareSize(80.0, context),
                  ),
                ),
                FutureBuilder(
                  future: getAppVersion(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return aboutListTile(title: 'MobWear');
                    }
                    return aboutListTile(
                        title: 'MobWear', subtitle: snapshot.data);
                  },
                ),
                FutureBuilder(
                  future: getDeviceID(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return aboutListTile(title: 'Device ID');
                    }
                    return aboutListTile(
                      title: 'Device ID',
                      subtitle: snapshot.data,
                      icon: LineAwesomeIcons.mobile_phone,
                    );
                  },
                ),
                aboutListTile(
                  title: 'Rate this app',
                  subtitle: 'If you love it and you know it give it 5 stars',
                  icon: LineAwesomeIcons.star_o,
                  onTap: () {},
                ),
                aboutListTile(
                  title: 'Share this app',
                  subtitle: 'Don\'t have all the fun alone',
                  icon: LineAwesomeIcons.share_alt,
                  onTap: () {},
                ),
                aboutListTile(
                    title: 'Send bug report',
                    subtitle: 'A bug sent is a bug squashed',
                    icon: LineAwesomeIcons.bug,
                    onTap: () {
                      // Hive.box(SettingsDatabase.settings).clear();
                    }),
                aboutListTile(
                  title: 'Developer Info',
                  subtitle: 'Find out who is behind this app',
                  icon: LineAwesomeIcons.code,
                  onTap: () {
                    showDialog<Widget>(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                        child: DeveloperInfoDialog(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget aboutListTile({
    String title,
    IconData icon,
    String subtitle,
    Function onTap,
  }) {
    return Column(
      children: <Widget>[
        Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisSize: MainAxisSize.min,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  icon != null ? Icon(icon, size: 18.0) : Container(),
                  SizedBox(width: 8.0),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              subtitle: subtitle != null
                  ? Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                      ),
                    )
                  : null,
            ),
            onTap: onTap,
          ),
        ),
        Divider(indent: 200.0, endIndent: 200.0),
      ],
    );
  }
}
