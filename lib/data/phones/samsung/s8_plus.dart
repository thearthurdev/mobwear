import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/brand_icons.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel_gradient.dart';
import 'package:mobwear/widgets/phone_widgets/button.dart';
import 'package:mobwear/widgets/phone_widgets/camera.dart';
import 'package:mobwear/widgets/phone_widgets/camera_bump.dart';
import 'package:mobwear/widgets/phone_widgets/fingerprint_sensor.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:mobwear/widgets/phone_widgets/heart_rate_sensor.dart';
import 'package:provider/provider.dart';

class S8Plus extends StatelessWidget {
  static final int phoneIndex = 0;
  static final int phoneID = 0203;
  static final int phoneBrandIndex = 1;
  static const String phoneBrand = 'Samsung';
  static const String phoneModel = 'Galaxy';
  static const String phoneName = 'Galaxy S8+';

  static String boxColorKey = 'Bezels';

  static List<Button> leftButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.right : ButtonPosition.left;

    return [
      Button(
        height: 36.0,
        yAlignment: -0.2,
        position: position,
        phoneID: phoneID,
        boxColorKey: boxColorKey,
      ),
    ];
  }

  static List<Button> rightButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.left : ButtonPosition.right;

    return [
      Button(
        height: 36.0,
        yAlignment: -0.68,
        position: position,
        phoneID: phoneID,
        boxColorKey: boxColorKey,
      ),
      Button(
        height: 36.0,
        yAlignment: -0.46,
        position: position,
        phoneID: phoneID,
        boxColorKey: boxColorKey,
      ),
    ];
  }

  final Screen front = Screen(
    phoneName: phoneName,
    phoneModel: phoneModel,
    phoneBrand: phoneBrand,
    phoneID: phoneID,
    screenWidth: 235.0,
    screenHeight: 510.0,
    horizontalPadding: 12.0,
    verticalPadding: 50.0,
    cornerRadius: 33.0,
    innerCornerRadius: 20.0,
    bezelsWidth: 2.0,
    screenAlignment: Alignment(0.0, 0.0),
    leftButtons: rightButtons(true),
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

    Color cameraBumpColor = colors['Camera'];
    Color backPanelColor = colors['Back Panel'];
    Color fingerprintSensorColor = colors['Fingerprint Sensor'];
    Color logoColor = colors['Samsung Logo'];
    Color bezelsColor = colors['Bezels'];

    String cameraBumpTexture = textures['Camera'].asset;
    Color cameraBumpTextureBlendColor = textures['Camera'].blendColor;
    BlendMode cameraBumpTextureBlendMode =
        kGetTextureBlendMode(textures['Camera'].blendModeIndex);

    String backPanelTexture = textures['Back Panel'].asset;
    Color backPanelTextureBlendColor = textures['Back Panel'].blendColor;
    BlendMode backPanelTextureBlendMode =
        kGetTextureBlendMode(textures['Back Panel'].blendModeIndex);

    CameraBump camera = CameraBump(
      width: 47.0,
      height: 47.0,
      cornerRadius: 14.0,
      borderWidth: 2.5,
      cameraBumpPartsPadding: 2.0,
      effectCornerRadius: 14.0,
      cameraBumpColor: cameraBumpColor,
      borderColor: cameraBumpTexture == null
          ? Colors.white.withOpacity(0.2)
          : Colors.transparent,
      backPanelColor: backPanelColor,
      texture: cameraBumpTexture,
      textureBlendColor: cameraBumpTextureBlendColor,
      textureBlendMode: cameraBumpTextureBlendMode,
      cameraBumpParts: [
        Align(
          alignment: Alignment.center,
          child: Camera(
            diameter: 26.0,
            trimColor: Colors.grey[800],
          ),
        ),
      ],
    );

    return FittedBox(
      child: BackPanel(
        width: 235.0,
        height: 510.0,
        cornerRadius: 33.0,
        bezelsWidth: 1.5,
        backPanelColor: backPanelColor,
        bezelsColor: bezelsColor,
        texture: backPanelTexture,
        textureBlendColor: backPanelTextureBlendColor,
        textureBlendMode: backPanelTextureBlendMode,
        leftButtons: leftButtons(false),
        rightButtons: rightButtons(false),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: BackPanelGradient(
                width: 229.0,
                height: 504.0,
                cornerRadius: 30.0,
                stops: [0.0, 0.04, 0.1, 0.2, 0.8, 0.9, 0.96, 1.0],
                backPanelColor: backPanelColor,
              ),
            ),
            Align(
              alignment: Alignment(-0.38, -0.73),
              child: HeartRateSensor(
                width: 12.0,
                height: 42.0,
                borderWidth: 0.0,
                cornerRadius: 4.0,
                flashSize: 10.0,
                dotSize: 8.0,
                hasFlash: true,
                color: Colors.black12,
                borderColor: Colors.transparent,
              ),
            ),
            Align(
              alignment: Alignment(0.0, -0.75),
              child: CameraBump(
                width: 50.0,
                height: 50.0,
                borderWidth: 0.3,
                cornerRadius: 16.0,
                cameraBumpPartsPadding: 0.0,
                hasElevation: false,
                backPanelColor: backPanelColor,
                cameraBumpColor: backPanelColor,
                borderColor: Colors.black,
                cameraBumpParts: [
                  Center(child: camera),
                ],
              ),
            ),
            Align(
              alignment: Alignment(0.48, -0.74),
              child: FingerprintSensor(
                phoneID: phoneID,
                width: 28.0,
                height: 48.0,
                sensorColor: fingerprintSensorColor,
              ),
            ),
            Align(
              alignment: Alignment(-0.145, -0.35),
              child: Icon(
                BrandIcons.samsung3,
                color: logoColor,
                size: 54.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
