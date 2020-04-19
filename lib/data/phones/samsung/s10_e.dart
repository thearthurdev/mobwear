import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/brand_icons.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel_gradient.dart';
import 'package:mobwear/widgets/phone_widgets/button.dart';
import 'package:mobwear/widgets/phone_widgets/camera.dart';
import 'package:mobwear/widgets/phone_widgets/camera_bump.dart';
import 'package:mobwear/widgets/phone_widgets/flash.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:mobwear/widgets/phone_widgets/heart_rate_sensor.dart';
import 'package:provider/provider.dart';

class S10E extends StatelessWidget {
  static final int phoneIndex = 0;
  static final int phoneID = 0208;
  static final int phoneBrandIndex = 1;
  static const String phoneBrand = 'Samsung';
  static const String phoneModel = 'Galaxy';
  static const String phoneName = 'S10e';

  static String boxColorKey = 'Bezels';

  static List<Button> rightButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.left : ButtonPosition.right;

    return [
      Button(
        height: 70.0,
        yAlignment: -0.71,
        position: position,
        phoneID: phoneID,
        boxColorKey: boxColorKey,
      ),
      Button(
        height: 40.0,
        yAlignment: -0.3,
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
    screenHeight: 490.0,
    horizontalPadding: 18.0,
    verticalPadding: 28.0,
    cornerRadius: 33.0,
    innerCornerRadius: 26.0,
    bezelsWidth: 2.0,
    screenAlignment: Alignment(0.0, -0.4),
    leftButtons: rightButtons(true),
    screenItems: <Widget>[
      Align(
        alignment: Alignment(0.8, -0.93),
        child: Camera(
          diameter: 20.0,
          trimColor: Colors.grey[850],
        ),
      ),
    ],
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

    Camera camera = Camera(
      width: 28.0,
      height: 28.0,
      trimColor: Colors.black,
    );

    CameraBump cameraBump = CameraBump(
      width: 128.0,
      height: 50.0,
      cornerRadius: 14.0,
      borderWidth: 2.0,
      cameraBumpPartsPadding: 2.0,
      effectCornerRadius: 14.0,
      elevationSpreadRadius: 0.3,
      hasEffect: false,
      hasElevation: false,
      cameraBumpColor: cameraBumpColor,
      // borderColor: cameraBumpTexture == null
      //     ? backPanelColor.computeLuminance() > 0.335
      //         ? Colors.white.withOpacity(0.5)
      //         : Colors.white.withOpacity(0.2)
      //     : Colors.transparent,
      borderColor: backPanelColor,
      backPanelColor: backPanelColor,
      texture: cameraBumpTexture,
      textureBlendColor: cameraBumpTextureBlendColor,
      textureBlendMode: cameraBumpTextureBlendMode,
      cameraBumpParts: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 1.0),
            camera,
            SizedBox(width: 6.0),
            camera,
            SizedBox(width: 1.0),
            Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: <Widget>[
                  Flash(
                    width: 16.0,
                    height: 16.0,
                    cornerRadius: 6.0,
                  ),
                  SizedBox(width: 2.0),
                  HeartRateSensor(
                    width: 12.0,
                    height: 14.0,
                    borderWidth: 0.0,
                    cornerRadius: 5.0,
                    dotSize: 8.0,
                    color: Colors.grey[900],
                    dot1Color: Colors.grey[850],
                    borderColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );

    return FittedBox(
      child: BackPanel(
        height: 490.0,
        cornerRadius: 33.0,
        bezelsWidth: 1.5,
        backPanelColor: backPanelColor,
        bezelsColor: bezelsColor,
        texture: backPanelTexture,
        textureBlendColor: backPanelTextureBlendColor,
        textureBlendMode: backPanelTextureBlendMode,
        rightButtons: rightButtons(false),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: BackPanelGradient(
                height: 490.0,
                cornerRadius: 31.0,
                stops: [0.0, 0.03, 0.07, 0.2, 0.8, 0.93, 0.97, 1.0],
                backPanelColor: backPanelColor,
              ),
            ),
            Align(
              alignment: Alignment(0.0, -0.75),
              child: CameraBump(
                width: 128.0,
                height: 46.0,
                borderWidth: 0.0,
                cornerRadius: 14.0,
                effectCornerRadius: 10.0,
                cameraBumpPartsPadding: 0.0,
                padding: 0.0,
                hasEffect: false,
                hasElevation: true,
                elevationSpreadRadius: 0.1,
                backPanelColor: backPanelColor,
                cameraBumpColor: backPanelColor,
                borderColor: backPanelColor,
                cameraBumpParts: [cameraBump],
              ),
            ),
            Align(
              alignment: Alignment(-0.145, -0.3),
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
