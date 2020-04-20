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
import 'package:provider/provider.dart';

class Note10Lite extends StatelessWidget {
  static final int phoneIndex = 1;
  static final int phoneID = 0213;
  static final int phoneBrandIndex = 1;
  static const String phoneBrand = 'Samsung';
  static const String phoneModel = 'Galaxy';
  static const String phoneName = 'Galaxy Note 10 Lite';

  static List<Button> leftButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.right : ButtonPosition.left;

    return [
      Button(
        height: 70.0,
        yAlignment: -0.55,
        position: position,
        phoneID: phoneID,
      ),
      Button(
        height: 40.0,
        yAlignment: -0.15,
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
    screenWidth: 235.0,
    screenHeight: 500.0,
    horizontalPadding: 14.0,
    verticalPadding: 22.0,
    cornerRadius: 24.0,
    innerCornerRadius: 16.0,
    bezelsWidth: 2.0,
    screenAlignment: Alignment(0.0, -0.28),
    rightButtons: leftButtons(true),
    screenItems: <Widget>[
      Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
    var phonesBox = Provider.of<CustomizationProvider>(context).phonesBox;

    var colors = phonesBox.get(phoneID).colors;
    var textures = phonesBox.get(phoneID).textures;

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
      width: 80.0,
      height: 95.0,
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
        Positioned(
          top: 10.0,
          left: 10.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              camera,
              SizedBox(height: 33.0),
              camera,
            ],
          ),
        ),
        Positioned(
          bottom: 10.0,
          right: 10.0,
          child: Column(
            children: <Widget>[
              Flash(diameter: 12.0),
              SizedBox(height: 36.0),
              camera,
            ],
          ),
        ),
      ],
    );

    return FittedBox(
      child: BackPanel(
        width: 235.0,
        height: 500.0,
        cornerRadius: 24.0,
        bezelsWidth: 1.5,
        backPanelColor: backPanelColor,
        bezelsColor: bezelsColor,
        texture: backPanelTexture,
        textureBlendColor: backPanelTextureBlendColor,
        textureBlendMode: backPanelTextureBlendMode,
        leftButtons: leftButtons(false),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: BackPanelGradient(
                width: 230.0,
                height: 496.0,
                cornerRadius: 20.0,
                stops: [0.0, 0.02, 0.06, 0.2, 0.8, 0.94, 0.98, 1.0],
                backPanelColor: backPanelColor,
              ),
            ),
            Positioned(
              top: 22.0,
              left: 22.0,
              child: cameraBump,
            ),
            Align(
              alignment: Alignment(-0.150, 0.6),
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
