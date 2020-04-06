import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/brand_icons.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/camera.dart';
import 'package:mobwear/widgets/phone_widgets/camera_bump.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:mobwear/widgets/phone_widgets/heart_rate_sensor.dart';
import 'package:provider/provider.dart';

class S7 extends StatelessWidget {
  static final int phoneIndex = 0;
  static final int phoneID = 0300;
  static final int phoneBrandIndex = 2;
  static const String phoneBrand = 'Samsung';
  static const String phoneModel = 'Galaxy';
  static const String phoneName = 'Galaxy S7';

  final Screen front = Screen(
    phoneName: phoneName,
    phoneModel: phoneModel,
    phoneBrand: phoneBrand,
    phoneID: phoneID,
    screenWidth: 240.0,
    screenHeight: 490.0,
    horizontalPadding: 6.0,
    verticalPadding: 25.0,
    screenAlignment: Alignment(0.0, -0.1),
    innerCornerRadius: 20.0,
    cornerRadius: 25.0,
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
    Color cameraBumpColor = colors['Camera'];
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

    Camera camera = Camera(
      diameter: 20.0,
      trimWidth: 3.0,
      lenseDiameter: 8.0,
      trimColor: Colors.grey[900],
    );

    CameraBump cameraBump = CameraBump(
      width: 60.0,
      height: 60.0,
      cornerRadius: 10.0,
      cameraBumpColor: cameraBumpColor,
      backPanelColor: backPanelColor,
      texture: cameraBumpTexture,
      textureBlendColor: cameraBumpTextureBlendColor,
      textureBlendMode: cameraBumpTextureBlendMode,
      cameraBumpPartsPadding: 2.0,
      borderWidth: 1.2,
      borderColor: Colors.grey[500],
      cameraBumpParts: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  camera,
                ],
              ),
            ],
          ),
        ),
      ],
    );

    return FittedBox(
      child: BackPanel(
        height: 490,
        cornerRadius: 32.0,
        bezelsWidth: 1.5,
        backPanelColor: backPanelColor,
        bezelsColor: bezelsColor,
        texture: backPanelTexture,
        textureBlendColor: backPanelTextureBlendColor,
        textureBlendMode: backPanelTextureBlendMode,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                cameraBump,
                SizedBox(width: 4.0),
                HeartRateSensor(),
              ],
            ),
            Icon(
              BrandIcons.samsung3,
              color: logoColor,
              size: 54.0,
            ),
          ],
        ),
      ),
    );
  }
}
