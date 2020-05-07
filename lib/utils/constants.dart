import 'package:flutter/material.dart';
import 'package:mobwear/data/models/blend_mode_model.dart';
import 'package:mobwear/data/models/brand_model.dart';
import 'package:mobwear/data/models/texture_model.dart';

const kTabletBreakpoint = 720.0;

const kDesktopBreakpoint = 1440.0;

const baseHeight = 640.0;

double kScreenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}

bool kIsWideScreen(BuildContext context) {
  return MediaQuery.of(context).size.width >= kTabletBreakpoint;
}

Color kPrimaryColor(BuildContext context) {
  return Theme.of(context).primaryColor;
}

Color kAccentColor(BuildContext context) {
  return Theme.of(context).accentColor;
}

Color kEstimateColorFromColorBrightness(Color color,
    {Color lightColor, Color darkColor}) {
  final double relativeLuminance = color.computeLuminance();
  const double kThreshold = 0.15;
  if ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > kThreshold)
    return darkColor;
  return lightColor;
}

// Color kEstimateColorFromImageBrightness(String image,
//     {Color lightColor, Color darkColor}) {
//   final double relativeLuminance = Image(image: image);
//   const double kThreshold = 0.15;
//   if ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > kThreshold)
//     return darkColor;
//   return lightColor;
// }

Color kBrightnessAwareColor(BuildContext context,
    {Color lightColor, Color darkColor}) {
  return kThemeBrightness(context) == Brightness.light ? lightColor : darkColor;
}

Brightness kThemeBrightness(BuildContext context) {
  return Theme.of(context).brightness;
}

TextStyle kAppBarTitleTextstyle(BuildContext context) {
  return Theme.of(context).appBarTheme.textTheme.headline6;
}

String kGetColorString(Color color) {
  String colorString =
      color.toString().split('x')[1].split(')')[0].toUpperCase();
  return colorString;
}

String kGetTextureName(String textureAsset) {
  String textureName = 'N/A';
  for (MyTexture texture in MyTexture.myTextures) {
    if (texture.asset == textureAsset) {
      textureName = texture.name;
    }
  }
  return textureName;
}

BlendMode kGetTextureBlendMode(int blendModeIndex) {
  return MyBlendMode.myBlendModes[blendModeIndex].mode;
}

String kGetTextureBlendModeName(int blendModeIndex) {
  return MyBlendMode.myBlendModes[blendModeIndex].name;
}

double kDeviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double kDeviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

bool kDeviceIsLandscape(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.landscape;
}

bool kDeviceIsPortrait(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.portrait;
}

IconData kGetBrandIconFromName(String name) {
  IconData icon;
  for (BrandModel brand in BrandModel.brands) {
    if (brand.brandName == name) {
      icon = brand.brandIcon.icon;
    }
  }
  return icon;
}

String kGetCombinedName(String name) {
  return name.splitMapJoin(" ", onMatch: (m) => '_', onNonMatch: (n) => '$n');
}

String kGetDateTime({String dateTime}) {
  String now = dateTime ?? DateTime.now().toString();

  String date = now
      .split(" ")[0]
      .splitMapJoin("-", onMatch: (m) => '', onNonMatch: (n) => '$n');

  String time = now
      .split(" ")[1]
      .split(".")[0]
      .splitMapJoin(":", onMatch: (m) => '', onNonMatch: (n) => '$n');

  return '${date}_$time';
}

const kTitleTextStyle = TextStyle(
  fontFamily: 'Quicksand',
  fontWeight: FontWeight.bold,
  letterSpacing: 0.3,
);

const kSubtitleTextStyle = TextStyle(
  fontFamily: 'Quicksand',
);
