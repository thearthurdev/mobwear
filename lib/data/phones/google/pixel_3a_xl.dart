import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/brand_icons.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/camera.dart';
import 'package:mobwear/widgets/phone_widgets/fingerprint_sensor.dart';
import 'package:mobwear/widgets/phone_widgets/flash.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:provider/provider.dart';

class Pixel3AXL extends StatelessWidget {
  static final int phoneIndex = 4;
  static final int phoneID = 0104;
  static final int phoneBrandIndex = 0;
  static const String phoneBrand = 'Google';
  static const String phoneModel = 'Pixel';
  static const String phoneName = 'Pixel 3A XL';

  final Screen front = Screen(
    phoneName: phoneName,
    phoneModel: phoneModel,
    phoneBrand: phoneBrand,
    phoneID: phoneID,
    verticalPadding: 70.0,
    cornerRadius: 26.0,
    bezelsWidth: 1.5,
    screenAlignment: Alignment(0.0, -0.2),
  );

  get getPhoneFront => front;
  get getPhoneName => phoneName;
  get getPhoneBrand => phoneBrand;
  get getPhoneBrandIndex => phoneBrandIndex;
  get getPhoneIndex => phoneIndex;

  @override
  Widget build(BuildContext context) {
    var phonesBox = Provider.of<CustomizationProvider>(context).phonesBox;

    var colors = phonesBox.get(phoneID).colors;
    var textures = phonesBox.get(phoneID).textures;

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
        cornerRadius: 26.0,
        bezelsWidth: 1.5,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 240.0,
                height: 380.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.0),
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
                  cornerRadius: 26.0,
                  bezelsWidth: 0.0,
                  noShadow: true,
                  backPanelColor: mattePanelColor,
                  texture: mattePanelTexture,
                  textureBlendColor: mattePanelTextureBlendColor,
                  textureBlendMode: mattePanelTextureBlendMode,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      FingerprintSensor(
                        sensorColor: fingerprintSensorColor,
                        diameter: 37.0,
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
                  SizedBox(width: 12.0),
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
