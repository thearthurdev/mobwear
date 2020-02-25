import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/utils/constants.dart';

class DeveloperInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kBrightnessAwareColor(context,
            lightColor: Color(0xFF757575), darkColor: Colors.black),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 8.0),
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
                'ArthurDev',
                style: TextStyle(
                  fontFamily: 'Righteous',
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 16.0),
              ListTile(
                leading: Icon(LineAwesomeIcons.github),
                title: Text('github.com/ArthurDevv'),
              ),
              ListTile(
                leading: Icon(LineAwesomeIcons.linkedin),
                title: Text('linkedin.com/in/arthurdelords'),
              ),
              ListTile(
                leading: Icon(LineAwesomeIcons.envelope_square),
                title: Text('arthurdelords@gmail.com'),
              ),
              ListTile(
                leading: Icon(LineAwesomeIcons.twitter),
                title: Text('@_DeeArthur'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
