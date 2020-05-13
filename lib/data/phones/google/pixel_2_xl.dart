import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/brand_icons.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/button.dart';
import 'package:mobwear/widgets/phone_widgets/camera.dart';
import 'package:mobwear/widgets/phone_widgets/fingerprint_sensor.dart';
import 'package:mobwear/widgets/phone_widgets/flash.dart';
import 'package:mobwear/widgets/phone_widgets/microphone.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class Pixel2XL extends StatelessWidget {
  static final int phoneIndex = 2;
  static final int phoneID = 0302;
  static final int phoneBrandIndex = 2;
  static const String phoneBrand = 'Google';
  static const String phoneModel = 'Pixel';
  static const String phoneName = 'Pixel 2 XL';

  static List<Button> leftButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.right : ButtonPosition.left;

    return [
      Button(
        height: 32.0,
        yAlignment: -0.45,
        position: position,
        phoneID: phoneID,
        boxColorKey: 'Power Button',
      ),
      Button(
        height: 80.0,
        yAlignment: -0.1,
        position: position,
        phoneID: phoneID,
        boxColorKey: 'Matte Panel',
      ),
    ];
  }

  final Screen front = Screen(
    phoneName: phoneName,
    phoneModel: phoneModel,
    phoneBrand: phoneBrand,
    phoneID: phoneID,
    verticalPadding: 50.0,
    cornerRadius: 23.0,
    bezelsWidth: 1.5,
    boxColorKey: 'Matte Panel',
    screenAlignment: Alignment.center,
    rightButtons: leftButtons(true),
  );

  get getPhoneFront => front;

  get getPhoneName => phoneName;
  get getPhoneBrand => phoneBrand;
  get getPhoneBrandIndex => phoneBrandIndex;
  get getPhoneIndex => phoneIndex;

  @override
  Widget build(BuildContext context) {
    Box<dynamic> phonesBox =
        Provider.of<CustomizationProvider>(context).phonesBox;

    Map<String, Color> colors = phonesBox.get(phoneID).colors;
    Map<String, MyTexture> textures = phonesBox.get(phoneID).textures;

    Color glossyPanelColor = colors['Glossy Panel'];
    Color mattePanelColor = colors['Matte Panel'];
    Color fingerprintSensorColor = colors['Fingerprint Sensor'];
    Color logoColor = colors['Google Logo'];

    String glossyPanelTexture = textures['Glossy Panel'].asset;
    Color glossyPanelTextureBlendColor = textures['Glossy Panel'].blendColor;
    BlendMode glossyPanelTextureBlendMode =
        kGetTextureBlendMode(textures['Glossy Panel'].blendModeIndex);

    String mattePanelTexture = textures['Matte Panel'].asset;
    Color mattePanelTextureBlendColor = textures['Matte Panel'].blendColor;
    BlendMode mattePanelTextureBlendMode =
        kGetTextureBlendMode(textures['Matte Panel'].blendModeIndex);

    return FittedBox(
      child: BackPanel(
        backPanelColor: mattePanelColor,
        bezelsColor: mattePanelColor,
        texture: mattePanelTexture,
        textureBlendColor: mattePanelTextureBlendColor,
        textureBlendMode: mattePanelTextureBlendMode,
        bezelsWidth: 0.4,
        leftButtons: leftButtons(false),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                BackPanel(
                  height: 100.0,
                  noShadow: true,
                  noButtons: true,
                  backPanelColor: glossyPanelColor,
                  texture: glossyPanelTexture,
                  textureBlendColor: glossyPanelTextureBlendColor,
                  textureBlendMode: glossyPanelTextureBlendMode,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(23.0),
                    topRight: Radius.circular(23.0),
                    bottomLeft: Radius.circular(2.0),
                    bottomRight: Radius.circular(2.0),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 110.0),
                  FingerprintSensor(
                    phoneID: phoneID,
                    diameter: 37.0,
                    boxColorKey: 'Matte Panel',
                    sensorColor: fingerprintSensorColor,
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Icon(
                    BrandIcons.google,
                    color: logoColor,
                    size: 26.0,
                  ),
                  SizedBox(height: 70.0),
                ],
              ),
            ),
            Positioned(
              top: 30.0,
              left: 25.0,
              child: Camera(
                trimColor: Colors.grey[800],
                lenseColor: Colors.grey[800],
                trimWidth: 3.0,
                elevationSpreadRadius: 0.2,
                elevationBlurRadius: 1.5,
                hasElevation: true,
              ),
            ),
            Positioned(
              top: 40.0,
              left: 70.0,
              child: Column(
                children: <Widget>[
                  Flash(diameter: 15.0),
                  SizedBox(height: 6.0),
                  Row(
                    children: <Widget>[
                      Microphone(),
                      SizedBox(width: 2.0),
                      Microphone(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
