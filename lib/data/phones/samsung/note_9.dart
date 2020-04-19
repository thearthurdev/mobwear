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
import 'package:mobwear/widgets/phone_widgets/flash.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:mobwear/widgets/phone_widgets/heart_rate_sensor.dart';
import 'package:provider/provider.dart';

class Note9 extends StatelessWidget {
  static final int phoneIndex = 0;
  static final int phoneID = 0207;
  static final int phoneBrandIndex = 1;
  static const String phoneBrand = 'Samsung';
  static const String phoneModel = 'Galaxy';
  static const String phoneName = 'Galaxy Note 9';

  static String boxColorKey = 'Bezels';

  static List<Button> leftButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.right : ButtonPosition.left;

    return [
      Button(
        height: 40.0,
        yAlignment: -0.4,
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
        height: 76.0,
        yAlignment: -0.66,
        position: position,
        phoneID: phoneID,
        boxColorKey: boxColorKey,
      ),
      Button(
        height: 40.0,
        yAlignment: -0.24,
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
    horizontalPadding: 10.0,
    verticalPadding: 44.0,
    cornerRadius: 16.0,
    innerCornerRadius: 12.0,
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

    Color cameraBumpColor = colors['Camera Bump'];
    Color backPanelColor = colors['Back Panel'];
    Color fingerprintSensorColor = colors['Fingerprint Sensor'];
    Color logoColor = colors['Samsung Logo'];
    Color bezelsColor = colors['Bezels'];

    String cameraBumpTexture = textures['Camera Bump'].asset;
    Color cameraBumpTextureBlendColor = textures['Camera Bump'].blendColor;
    BlendMode cameraBumpTextureBlendMode =
        kGetTextureBlendMode(textures['Camera Bump'].blendModeIndex);

    String backPanelTexture = textures['Back Panel'].asset;
    Color backPanelTextureBlendColor = textures['Back Panel'].blendColor;
    BlendMode backPanelTextureBlendMode =
        kGetTextureBlendMode(textures['Back Panel'].blendModeIndex);

    CameraBump cameraBump = CameraBump(
      width: 128.0,
      height: 50.0,
      cornerRadius: 10.0,
      borderWidth: 1.0,
      cameraBumpPartsPadding: 2.0,
      effectCornerRadius: 14.0,
      hasEffect: false,
      hasElevation: false,
      cameraBumpColor: cameraBumpColor,
      borderColor: cameraBumpTexture == null
          ? Colors.white.withOpacity(0.2)
          : Colors.transparent,
      backPanelColor: backPanelColor,
      texture: cameraBumpTexture,
      textureBlendColor: cameraBumpTextureBlendColor,
      textureBlendMode: cameraBumpTextureBlendMode,
      cameraBumpParts: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Camera(
              diameter: 26.0,
              trimWidth: 3.0,
              trimColor: Colors.grey[800],
            ),
            SizedBox(width: 6.0),
            Camera(
              diameter: 34.0,
              trimWidth: 3.0,
              trimColor: Colors.grey[800],
            ),
            SizedBox(width: 1.0),
            Flash(
              width: 14.0,
              height: 14.0,
              cornerRadius: 4.0,
            ),
            HeartRateSensor(
              width: 14.0,
              height: 32.0,
              borderWidth: 0.0,
              cornerRadius: 5.0,
              dotSize: 8.0,
              color: Colors.grey[900],
              borderColor: Colors.transparent,
            ),
          ],
        ),
      ],
    );

    return FittedBox(
      child: BackPanel(
        width: 235.0,
        height: 510.0,
        cornerRadius: 16.0,
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
                cornerRadius: 12.0,
                stops: [0.0, 0.04, 0.1, 0.2, 0.8, 0.9, 0.96, 1.0],
                backPanelColor: backPanelColor,
              ),
            ),
            Align(
              alignment: Alignment(0.0, -0.75),
              child: CameraBump(
                width: 128.0,
                height: 46.0,
                borderWidth: 0.3,
                cornerRadius: 10.0,
                effectCornerRadius: 10.0,
                cameraBumpPartsPadding: 0.0,
                padding: 0.0,
                hasEffect: false,
                elevationSpreadRadius: 0.1,
                backPanelColor: backPanelColor,
                cameraBumpColor: Colors.white.withOpacity(0.04),
                borderColor: Colors.black,
                cameraBumpParts: [cameraBump],
              ),
            ),
            Align(
              alignment: Alignment(0.0, -0.52),
              child: FingerprintSensor(
                phoneID: phoneID,
                width: 44.0,
                height: 28.0,
                trimWidth: 1.5,
                cornerRadius: 8.0,
                sensorColor: fingerprintSensorColor,
              ),
            ),
            Align(
              alignment: Alignment(-0.145, -0.31),
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
