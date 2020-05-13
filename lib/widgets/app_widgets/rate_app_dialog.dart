import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobwear/providers/settings_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/adaptiveDialog.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class RateAppDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kBrightnessAwareColor(context,
            lightColor: Color(0xFF757575), darkColor: Colors.black),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: AdaptiveDialog(
        title: 'Rate this app',
        selectText: 'Later',
        cancelText: 'Never',
        onSelectPressed: () => Navigator.pop(context),
        onCancelPressed: () {
          Provider.of<SettingsProvider>(context, listen: false)
              .changeRateAppStatus(2);
          Navigator.pop(context);
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Are you enjoying MobWear?\nLet us know by giving it a review',
                  style: kTitleTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.0),
                dialogButton(
                    context: context,
                    label: 'Rate',
                    onTap: () {
                      launchURL(context);
                      Provider.of<SettingsProvider>(context, listen: false)
                          .changeRateAppStatus(1);
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void launchURL(BuildContext context) async {
    String url =
        'https://play.google.com/store/apps/details?id=com.arthurdev.mobwear';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // throw 'Could not launch $url';
      Toast.show(
        'Couldn\'t open the Play Store\nPlease try again later',
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

  Widget dialogButton({BuildContext context, String label, Function onTap}) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kBrightnessAwareColor(context,
            lightColor: Colors.black, darkColor: Colors.white),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: onTap,
          child: Center(
            child: Text(
              label,
              style: kTitleTextStyle.copyWith(
                color: kBrightnessAwareColor(context,
                    lightColor: Colors.white, darkColor: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
