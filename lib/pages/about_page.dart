import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/custom_icons/custom_icons.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/developer_info_dialog.dart';
import 'package:package_info/package_info.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class AboutPage extends StatelessWidget {
  static const String id = '/AboutPage';

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
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
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('About'),
              centerTitle: true,
              pinned: true,
              leading: IconButton(
                icon: Icon(LineAwesomeIcons.angle_left),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SliverSafeArea(
              sliver: SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: kScreenAwareSize(16.0, context)),
                      Center(
                        child: Container(
                          width: kScreenAwareSize(100.0, context),
                          height: kScreenAwareSize(100.0, context),
                          decoration: BoxDecoration(
                            color: kBrightnessAwareColor(context,
                                lightColor: Colors.black,
                                darkColor: Colors.white),
                            borderRadius: BorderRadius.circular(
                                kScreenAwareSize(16.0, context)),
                          ),
                          child: Icon(
                            CustomIcons.mobwear,
                            color: kBrightnessAwareColor(context,
                                lightColor: Colors.white,
                                darkColor: Colors.black),
                            size: kScreenAwareSize(80.0, context),
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: getAppVersion(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return aboutListTile(title: 'MobWear');
                          }
                          return aboutListTile(
                              title: 'MobWear', subtitle: snapshot.data);
                        },
                      ),
                      aboutListTile(
                        title: 'Rate this app',
                        subtitle:
                            'If you love it and you know it give it 5 stars',
                        icon: LineAwesomeIcons.star_o,
                        onTap: () => launchURL(
                          context,
                          url:
                              'https://play.google.com/store/apps/details?id=com.arthurdev.mobwear',
                        ),
                      ),
                      aboutListTile(
                        title: 'Share this app',
                        subtitle: 'Don\'t have all the fun alone',
                        icon: LineAwesomeIcons.share_alt,
                        onTap: () {
                          Share.text(
                              'Share MobWear',
                              'Hey, check out Mobwear! It\'s a brand new smartphone customization app and it\'s very fun.\nDownload it here: bit.ly/download-mobwear-android',
                              'text/plain');
                        },
                      ),
                      aboutListTile(
                        title: 'Report a bug',
                        subtitle: 'A bug reported is a bug squashed',
                        icon: LineAwesomeIcons.bug,
                        onTap: () => launchURL(context,
                            url:
                                'mailto:arthurdelords@gmail.com?subject=MobWear%20Bug%20Report&body='),
                      ),
                      aboutListTile(
                        title: 'Developer Info',
                        subtitle: 'Find out who is behind this app',
                        icon: LineAwesomeIcons.code,
                        onTap: () {
                          showDialog<Widget>(
                            context: context,
                            builder: (BuildContext context) =>
                                DeveloperInfoDialog(),
                          );
                        },
                      ),
                      SizedBox(height: kScreenAwareSize(16.0, context)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void launchURL(BuildContext context, {String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // throw 'Could not launch $url';
      Toast.show(
        'Couldn\'t complete action\nPlease try again later',
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

  Widget aboutListTile({
    String title,
    IconData icon,
    String subtitle,
    Function onTap,
    Function onLongPress,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
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
              onLongPress: onLongPress,
            ),
          ),
        ],
      ),
    );
  }
}
