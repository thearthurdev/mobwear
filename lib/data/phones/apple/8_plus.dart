import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/brand_icons.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/button.dart';
import 'package:mobwear/widgets/phone_widgets/camera.dart';
import 'package:mobwear/widgets/phone_widgets/camera_bump.dart';
import 'package:mobwear/widgets/phone_widgets/flash.dart';
import 'package:mobwear/widgets/phone_widgets/iPhone_home_button.dart';
import 'package:mobwear/widgets/phone_widgets/iPhone_text_marks.dart';
import 'package:mobwear/widgets/phone_widgets/microphone.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:provider/provider.dart';

class IPhone8Plus extends StatelessWidget {
  static final int phoneIndex = 9;
  static final int phoneID = 0109;
  static final int phoneBrandIndex = 0;
  static const String phoneBrand = 'Apple';
  static const String phoneModel = 'iPhone';
  static const String phoneName = 'iPhone 8 Plus';

  static List<Button> leftButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.right : ButtonPosition.left;

    return [
      Button(
        height: 35.0,
        yAlignment: -0.6,
        position: position,
        phoneID: phoneID,
      ),
    ];
  }

  static List<Button> rightButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.left : ButtonPosition.right;

    return [
      Button(
        height: 16.0,
        yAlignment: -0.7,
        position: position,
        phoneID: phoneID,
      ),
      Button(
        height: 35.0,
        yAlignment: -0.55,
        position: position,
        phoneID: phoneID,
      ),
      Button(
        height: 35.0,
        yAlignment: -0.36,
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
    screenWidth: 250.0,
    horizontalPadding: 24.0,
    verticalPadding: 110.0,
    innerCornerRadius: 0.0,
    bezelsWidth: 2.0,
    screenFaceColor: Colors.white,
    leftButtons: rightButtons(true),
    rightButtons: leftButtons(true),
    screenItems: <Widget>[
      Align(
        alignment: Alignment(0.0, 0.965),
        child: IPhoneHomeButton(
          phoneID: phoneID,
          diameter: 38.0,
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
    Color logoColor = colors['Apple Logo'];
    Color textMarksColor = colors['iPhone Text'];
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
      lenseDiameter: 12.0,
      trimWidth: 3.0,
      trimColor: Colors.white.withOpacity(0.2),
      hasElevation: true,
    );

    CameraBump cameraBump = CameraBump(
      width: 80.0,
      height: 36.0,
      borderWidth: 2.5,
      elevationSpreadRadius: 1.0,
      elevationBlurRadius: 4.0,
      cameraBumpColor: cameraBumpColor,
      texture: cameraBumpTexture,
      textureBlendColor: cameraBumpTextureBlendColor,
      textureBlendMode: cameraBumpTextureBlendMode,
      backPanelColor: backPanelColor,
      borderColor: backPanelColor,
      cameraBumpPartsPadding: 0.0,
      cameraBumpParts: [
        Positioned(
          left: 2.0,
          top: 4.0,
          child: camera,
        ),
        Positioned(
          right: 2.0,
          top: 4.0,
          child: camera,
        ),
      ],
    );

    return FittedBox(
      child: BackPanel(
        width: 250.0,
        height: 500.0,
        cornerRadius: 36.0,
        bezelsWidth: 3.0,
        backPanelColor: backPanelColor,
        bezelsColor: bezelsColor,
        texture: backPanelTexture,
        textureBlendColor: backPanelTextureBlendColor,
        textureBlendMode: backPanelTextureBlendMode,
        leftButtons: leftButtons(false),
        rightButtons: rightButtons(false),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 12.0,
              left: 12.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  cameraBump,
                  SizedBox(width: 6.0),
                  Microphone(),
                  SizedBox(width: 6.0),
                  Flash(diameter: 13.0),
                ],
              ),
            ),
            Align(
              alignment: Alignment(0.0, -0.5),
              child: Icon(
                BrandIcons.apple,
                color: logoColor,
                size: 60.0,
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.6),
              child: IPhoneTextMarks(
                color: textMarksColor,
                ceMarkings: false,
                designedByText: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
