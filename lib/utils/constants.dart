import 'package:flutter/material.dart';

double baseHeight = 640.0;

double kScreenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}

Color kPrimaryColor(BuildContext context) {
  return Theme.of(context).primaryColor;
}

Color kAccentColor(BuildContext context) {
  return Theme.of(context).accentColor;
}

Color kBrightnessAwareColor(BuildContext context,
    {Color lightColor, darkColor}) {
  return kThemeBrightness(context) == Brightness.light ? lightColor : darkColor;
}

Brightness kThemeBrightness(BuildContext context) {
  return Theme.of(context).brightness;
}

TextStyle kAppBarTitleTextstyle(BuildContext context) {
  return Theme.of(context).appBarTheme.textTheme.title;
}

String kGetColorString(Color color) {
  String colorString =
      color.toString().split('x')[1].split(')')[0].toUpperCase();
  return colorString;
}

double kDeviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double kDeviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

const kTitleTextStyle = TextStyle(
  fontFamily: 'Quicksand',
  fontWeight: FontWeight.bold,
  letterSpacing: 0.3,
);
