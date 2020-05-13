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
import 'package:mobwear/widgets/phone_widgets/microphone.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class Note10Plus extends StatelessWidget {
  static final int phoneIndex = 10;
  static final int phoneID = 0210;
  static final int phoneBrandIndex = 1;
  static const String phoneBrand = 'Samsung';
  static const String phoneModel = 'Galaxy';
  static const String phoneName = 'Galaxy Note 10+';

  static List<Button> rightButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.left : ButtonPosition.right;

    return [
      Button(
        height: 70.0,
        yAlignment: -0.7,
        position: position,
        phoneID: phoneID,
      ),
      Button(
        height: 40.0,
        yAlignment: -0.3,
        position: position,
        phoneID: phoneID,
      ),
    ];
  }

  final Screen front = Screen(
    phoneName: phoneName,
    phoneModel: phoneModel,
    phoneBrand: phoneBrand,
    phoneID: phoneID,
    screenWidth: 240.0,
    screenHeight: 510.0,
    horizontalPadding: 8.0,
    verticalPadding: 15.0,
    screenAlignment: Alignment(0.0, -0.35),
    innerCornerRadius: 8.0,
    cornerRadius: 6.0,
    leftButtons: rightButtons(true),
    screenItems: <Widget>[
      Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Camera(
            diameter: 15.0,
            lenseDiameter: 5.0,
            trimWidth: 0.0,
          ),
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
    Box<dynamic> phonesBox =
        Provider.of<CustomizationProvider>(context).phonesBox;

    Map<String, Color> colors = phonesBox.get(phoneID).colors;
    Map<String, MyTexture> textures = phonesBox.get(phoneID).textures;

    Color backPanelColor = colors['Back Panel'];
    Color cameraBumpColor = colors['Camera Bump'];
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
      diameter: 20.0,
      trimWidth: 3.0,
      lenseDiameter: 8.0,
      trimColor: Colors.grey[900],
    );

    CameraBump cameraBump = CameraBump(
      width: 35.0,
      height: 105.0,
      borderWidth: 1.5,
      cameraBumpPartsPadding: 2.0,
      elevationSpreadRadius: 0.3,
      cameraBumpColor: cameraBumpColor,
      backPanelColor: backPanelColor,
      texture: cameraBumpTexture,
      textureBlendColor: cameraBumpTextureBlendColor,
      textureBlendMode: cameraBumpTextureBlendMode,
      borderColor: cameraBumpTexture == null
          ? backPanelColor.computeLuminance() > 0.335
              ? Colors.grey[400].withOpacity(0.7)
              : Colors.grey[700].withOpacity(0.7)
          : Colors.transparent,
      cameraBumpParts: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              camera,
              camera,
              camera,
            ],
          ),
        ),
      ],
    );

    return FittedBox(
      child: BackPanel(
        width: 235.0,
        height: 510.0,
        cornerRadius: 6.0,
        bezelsWidth: 0.5,
        backPanelColor: backPanelColor,
        bezelsColor: bezelsColor,
        texture: backPanelTexture,
        textureBlendColor: backPanelTextureBlendColor,
        textureBlendMode: backPanelTextureBlendMode,
        rightButtons: rightButtons(false),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: BackPanelGradient(
                width: 235.0,
                height: 510.0,
                cornerRadius: 6.0,
                stops: [0.0, 0.02, 0.06, 0.2, 0.8, 0.94, 0.98, 1.0],
                backPanelColor: backPanelColor,
              ),
            ),
            Align(
              alignment: Alignment(-0.150, -0.3),
              child: Icon(
                BrandIcons.samsung3,
                color: logoColor,
                size: 54.0,
              ),
            ),
            Positioned(
              top: 26.0,
              left: 24.0,
              child: cameraBump,
            ),
            Positioned(
              left: 70.0,
              top: 42.0,
              child: Column(
                children: <Widget>[
                  Flash(diameter: 10.0),
                  SizedBox(height: 8.0),
                  Microphone(diameter: 10.0),
                  SizedBox(height: 8.0),
                  Microphone(diameter: 10.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
