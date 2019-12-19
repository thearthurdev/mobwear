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

Brightness kThemeBrightness(BuildContext context) {
  return Theme.of(context).brightness;
}

TextStyle kAppBarTitleTextstyle(BuildContext context) {
  return Theme.of(context).appBarTheme.textTheme.title;
}

const kTitleTextStyle = TextStyle(
  fontSize: 24.0,
  fontFamily: 'Righteous',
);
