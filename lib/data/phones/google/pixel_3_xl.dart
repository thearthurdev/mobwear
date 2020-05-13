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

class Pixel3XL extends StatelessWidget {
  static final int phoneIndex = 3;
  static final int phoneID = 0303;
  static final int phoneBrandIndex = 2;
  static const String phoneBrand = 'Google';
  static const String phoneModel = 'Pixel';
  static const String phoneName = 'Pixel 3 XL';

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
        boxColorKey: 'Bezels',
      ),
    ];
  }

  final Screen front = Screen(
    phoneName: phoneName,
    phoneModel: phoneModel,
    phoneBrand: phoneBrand,
    phoneID: phoneID,
    hasNotch: true,
    verticalPadding: 40.0,
    notchHeight: 35.0,
    notchWidth: 90.0,
    cornerRadius: 23.0,
    bezelsWidth: 1.5,
    notchAlignment: Alignment(0.0, -1.0),
    screenAlignment: Alignment(0.0, -0.6),
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
    Color bezelsColor = colors['Bezels'];

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
        backPanelColor: glossyPanelColor,
        bezelsColor: bezelsColor,
        texture: glossyPanelTexture,
        textureBlendColor: glossyPanelTextureBlendColor,
        textureBlendMode: glossyPanelTextureBlendMode,
        leftButtons: leftButtons(false),
        bezelsWidth: 1.5,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 240.0,
                height: 380.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23.0),
                  border: mattePanelTexture == null
                      ? Border.all(
                          color: Colors.grey.withOpacity(0.05),
                          width: 1.0,
                        )
                      : null,
                  color: mattePanelColor,
                ),
                child: BackPanel(
                  width: 240.0,
                  height: 380.0,
                  cornerRadius: 23.0,
                  bezelsWidth: 0.0,
                  noShadow: true,
                  noButtons: true,
                  backPanelColor: mattePanelColor,
                  texture: mattePanelTexture,
                  textureBlendColor: mattePanelTextureBlendColor,
                  textureBlendMode: mattePanelTextureBlendMode,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
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
              ),
            ),
            Positioned(
              top: 30.0,
              left: 20.0,
              child: Row(
                children: <Widget>[
                  Camera(
                    trimColor: Colors.grey[700],
                    lenseColor: Colors.grey[700],
                    trimWidth: 3.0,
                    elevationSpreadRadius: 0.5,
                    hasElevation: true,
                  ),
                  SizedBox(width: 8.0),
                  Microphone(),
                  SizedBox(width: 8.0),
                  Flash(
                    diameter: 15.0,
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
