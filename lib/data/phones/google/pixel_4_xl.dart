import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/brand_icons.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/button.dart';
import 'package:mobwear/widgets/phone_widgets/camera.dart';
import 'package:mobwear/widgets/phone_widgets/camera_bump.dart';
import 'package:mobwear/widgets/phone_widgets/flash.dart';
import 'package:mobwear/widgets/phone_widgets/microphone.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:provider/provider.dart';

class Pixel4XL extends StatelessWidget {
  static final int phoneIndex = 5;
  static final int phoneID = 0305;
  static final int phoneBrandIndex = 2;
  static const String phoneBrand = 'Google';
  static const String phoneModel = 'Pixel';
  static const String phoneName = 'Pixel 4 XL';

  static List<Button> leftButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.right : ButtonPosition.left;

    return [
      Button(
        height: 32.0,
        yAlignment: -0.5,
        position: position,
        phoneID: phoneID,
        boxColorKey: 'Power Button',
      ),
      Button(
        height: 80.0,
        yAlignment: -0.2,
        position: position,
        phoneID: phoneID,
        color: Colors.black,
      ),
    ];
  }

  final Screen front = Screen(
    phoneName: phoneName,
    phoneModel: phoneModel,
    phoneBrand: phoneBrand,
    phoneID: phoneID,
    verticalPadding: 40.0,
    bezelsWidth: 1.5,
    screenAlignment: Alignment(0.0, 0.5),
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
    Color logoColor = colors['Google Logo'];
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
      diameter: 28.0,
      trimWidth: 3.0,
      trimColor: Colors.white.withOpacity(0.03),
    );

    CameraBump cameraBump = CameraBump(
      width: 80.0,
      height: 80.0,
      borderWidth: 1.0,
      borderColor: cameraBumpColor.withOpacity(0.05),
      cameraBumpColor: cameraBumpColor,
      backPanelColor: backPanelColor,
      texture: cameraBumpTexture,
      textureBlendColor: cameraBumpTextureBlendColor,
      textureBlendMode: cameraBumpTextureBlendMode,
      cameraBumpPartsPadding: 2.0,
      cameraBumpParts: [
        Positioned(
          left: 5.0,
          top: 22.5,
          child: camera,
        ),
        Positioned(
          right: 5.0,
          top: 22.5,
          child: camera,
        ),
        Positioned(
          left: 32.5,
          bottom: 7.0,
          child: Flash(diameter: 15.0),
        ),
        Positioned(
          right: 17.0,
          bottom: 11.0,
          child: Microphone(),
        ),
        Positioned(
          left: 37.0,
          top: 10.0,
          child: Microphone(),
        ),
      ],
    );

    return FittedBox(
      child: BackPanel(
        cornerRadius: 30.0,
        bezelsWidth: 4.0,
        backPanelColor: backPanelColor,
        bezelsColor: bezelsColor,
        texture: backPanelTexture,
        textureBlendColor: backPanelTextureBlendColor,
        textureBlendMode: backPanelTextureBlendMode,
        leftButtons: leftButtons(false),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              children: <Widget>[
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
            Positioned(
              top: 10.0,
              left: 10.0,
              child: cameraBump,
            ),
          ],
        ),
      ),
    );
  }
}
