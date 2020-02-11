import 'package:flutter/material.dart';
import 'package:mobware/data/models/blend_mode_model.dart';
import 'package:mobware/data/models/texture_model.dart';

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
  return Theme.of(context).appBarTheme.textTheme.title;
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

// int kGetTextureBlendModeIndex(BlendMode blendModeIndex) {
//   int textureBlendModeIndex;
//   int i = 0;
//   for (MyBlendMode myBlendMode in myBlendModes) {
//     if (myBlendMode.mode == blendModeIndex) {
//       textureBlendModeIndex = i;
//     }
//     i++;
//   }
//   return textureBlendModeIndex;
// }

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

const kSubtitleTextStyle = TextStyle(
  fontFamily: 'Quicksand',
);
