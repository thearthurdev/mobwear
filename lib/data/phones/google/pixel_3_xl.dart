import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/brand_icons.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/camera.dart';
import 'package:mobwear/widgets/phone_widgets/fingerprint_sensor.dart';
import 'package:mobwear/widgets/phone_widgets/flash.dart';
import 'package:mobwear/widgets/phone_widgets/microphone.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:mobwear/widgets/phone_widgets/texture_decoration.dart';
import 'package:provider/provider.dart';

class Pixel3XL extends StatelessWidget {
  static final int phoneIndex = 3;
  static final int phoneBrandIndex = 0;
  static const String phoneBrand = 'Google';
  static const String phoneModel = 'Pixel';
  static const String phoneName = 'Pixel 3 XL';

  final Screen front = Screen(
    phoneName: phoneName,
    phoneModel: phoneModel,
    phoneBrand: phoneBrand,
    hasNotch: true,
    bezelVertical: 40.0,
    screenAlignment: Alignment(0.0, -0.6),
    notchAlignment: Alignment(0.0, -1.0),
    notchHeight: 35.0,
    notchWidth: 100.0,
    cornerRadius: 23.0,
  );

  get getPhoneFront => front;
  get getPhoneName => phoneName;
  get getPhoneBrand => phoneBrand;
  get getPhoneBrandIndex => phoneBrandIndex;
  get getPhoneIndex => phoneIndex;

  @override
  Widget build(BuildContext context) {
    var phonesBox = Provider.of<CustomizationProvider>(context).phonesBox;

    var colors = phonesBox.get(0103).colors;
    var textures = phonesBox.get(0103).textures;

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
        backPanelColor: glossyPanelColor,
        bezelColor: glossyPanelColor,
        texture: glossyPanelTexture,
        textureBlendColor: glossyPanelTextureBlendColor,
        textureBlendMode: glossyPanelTextureBlendMode,
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
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        mattePanelColor.computeLuminance() > 0.335
                            ? Colors.black12
                            : Colors.black26
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    image: textureDecoration(
                      texture: mattePanelTexture,
                      textureBlendColor: mattePanelTextureBlendColor,
                      textureBlendMode: mattePanelTextureBlendMode,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      FingerprintSensor(
                        sensorColor: fingerprintSensorColor,
                        diameter: 37.0,
                        trimColor: mattePanelColor,
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Icon(
                        BrandIcons.google,
                        color: logoColor,
                        size: 30.0,
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
                  Camera(),
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