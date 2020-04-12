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
import 'package:mobwear/widgets/phone_widgets/texture_decoration.dart';
import 'package:provider/provider.dart';

class PixelXL extends StatelessWidget {
  static final int phoneIndex = 0;
  static final int phoneID = 0300;
  static final int phoneBrandIndex = 2;
  static const String phoneBrand = 'Google';
  static const String phoneModel = 'Pixel';
  static const String phoneName = 'Pixel XL';

  static List<Button> leftButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.right : ButtonPosition.left;

    return [
      Button(
        height: 32.0,
        yAlignment: -0.45,
        position: position,
        phoneID: phoneID,
        boxColorKey: 'Matte Panel',
      ),
      Button(
        height: 80.0,
        yAlignment: -0.08,
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
    verticalPadding: 120.0,
    innerCornerRadius: 0.0,
    cornerRadius: 33.0,
    bezelsWidth: 1.5,
    boxColorKey: 'Matte Panel',
    screenFaceColor: Colors.white,
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
    var phonesBox = Provider.of<CustomizationProvider>(context).phonesBox;

    var colors = phonesBox.get(phoneID).colors;
    var textures = phonesBox.get(phoneID).textures;

    Color glossyPanelColor = colors['Glossy Panel'];
    Color mattePanelColor = colors['Matte Panel'];
    Color fingerprintSensorColor = colors['Fingerprint Sensor'];
    Color logoColor = colors['Google Logo'];
    Color antennaBandsColor = colors['Antenna Bands'];

    String glossyPanelTexture = textures['Glossy Panel'].asset;
    Color glossyPanelTextureBlendColor = textures['Glossy Panel'].blendColor;
    BlendMode glossyPanelTextureBlendMode =
        kGetTextureBlendMode(textures['Glossy Panel'].blendModeIndex);

    String mattePanelTexture = textures['Matte Panel'].asset;
    Color mattePanelTextureBlendColor = textures['Matte Panel'].blendColor;
    BlendMode mattePanelTextureBlendMode =
        kGetTextureBlendMode(textures['Matte Panel'].blendModeIndex);

    String antennaBandsTexture = textures['Antenna Bands'].asset;
    Color antennaBandsTextureBlendColor = textures['Antenna Bands'].blendColor;
    BlendMode antennaBandsTextureBlendMode =
        kGetTextureBlendMode(textures['Antenna Bands'].blendModeIndex);

    Container antennaBandHorizontal() {
      return Container(
        height: 6.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: antennaBandsColor,
          image: textureDecoration(
            texture: antennaBandsTexture,
            textureBlendColor: antennaBandsTextureBlendColor,
            textureBlendMode: antennaBandsTextureBlendMode,
          ),
        ),
      );
    }

    Container antennaBandVertical() {
      return Container(
        height: 40.0,
        width: 6.0,
        decoration: BoxDecoration(
          color: antennaBandsColor,
          image: textureDecoration(
            texture: antennaBandsTexture,
            textureBlendColor: antennaBandsTextureBlendColor,
            textureBlendMode: antennaBandsTextureBlendMode,
          ),
        ),
      );
    }

    return FittedBox(
      child: BackPanel(
        height: 470.0,
        width: 233.0,
        cornerRadius: 30.0,
        backPanelColor: mattePanelColor,
        bezelsColor: mattePanelColor,
        texture: mattePanelTexture,
        textureBlendColor: mattePanelTextureBlendColor,
        textureBlendMode: mattePanelTextureBlendMode,
        leftButtons: leftButtons(false),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 54.5,
                child: antennaBandVertical(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(height: 40.0),
                  antennaBandHorizontal(),
                  Expanded(
                    child: Container(),
                  ),
                  Icon(
                    BrandIcons.google,
                    color: logoColor,
                    size: 26.0,
                  ),
                  SizedBox(height: 60.0),
                  antennaBandHorizontal(),
                  SizedBox(height: 20.0),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.all(6.0),
                  width: 240.0,
                  height: 160.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                    color: glossyPanelColor,
                    image: textureDecoration(
                      texture: glossyPanelTexture,
                      textureBlendColor: glossyPanelTextureBlendColor,
                      textureBlendMode: glossyPanelTextureBlendMode,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: FingerprintSensor(
                          diameter: 45.0,
                          sensorColor: fingerprintSensorColor,
                          trimColor: Colors.black.withOpacity(0.05)),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20.0,
                left: 20.0,
                child: Row(
                  children: <Widget>[
                    Flash(diameter: 15.0),
                    SizedBox(width: 14.0),
                    Camera(
                      diameter: 17.0,
                      trimWidth: 3.0,
                      lenseDiameter: 7.0,
                    ),
                    SizedBox(width: 18.0),
                    Microphone(diameter: 6),
                    SizedBox(width: 6.0),
                    Microphone(diameter: 6),
                    SizedBox(width: 7.0),
                    Microphone(diameter: 3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
