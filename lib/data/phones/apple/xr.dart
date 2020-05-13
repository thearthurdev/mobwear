import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/brand_icons.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/button.dart';
import 'package:mobwear/widgets/phone_widgets/camera.dart';
import 'package:mobwear/widgets/phone_widgets/flash.dart';
import 'package:mobwear/widgets/phone_widgets/iPhone_text_marks.dart';
import 'package:mobwear/widgets/phone_widgets/microphone.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class IPhoneXR extends StatelessWidget {
  static final int phoneIndex = 10;
  static final int phoneID = 0110;
  static final int phoneBrandIndex = 0;
  static const String phoneBrand = 'Apple';
  static const String phoneModel = 'iPhone';
  static const String phoneName = 'iPhone XR';

  static String boxColorKey = 'Bezels';

  static List<Button> leftButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.right : ButtonPosition.left;

    return [
      Button(
        height: 60.0,
        yAlignment: -0.45,
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
        height: 16.0,
        yAlignment: -0.7,
        position: position,
        phoneID: phoneID,
        boxColorKey: boxColorKey,
      ),
      Button(
        height: 40.0,
        yAlignment: -0.55,
        position: position,
        phoneID: phoneID,
        boxColorKey: boxColorKey,
      ),
      Button(
        height: 40.0,
        yAlignment: -0.33,
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
    hasNotch: true,
    screenWidth: 250.0,
    horizontalPadding: 24.0,
    verticalPadding: 24.0,
    bezelsWidth: 2.0,
    leftButtons: rightButtons(true),
    rightButtons: leftButtons(true),
  );

  get getPhoneName => phoneName;
  get getPhoneFront => front;
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
    Color logoColor = colors['Apple Logo'];
    Color textMarksColor = colors['Texts & Markings'];
    Color bezelsColor = colors['Bezels'];

    String backPanelTexture = textures['Back Panel'].asset;
    Color backPanelTextureBlendColor = textures['Back Panel'].blendColor;
    BlendMode backPanelTextureBlendMode =
        kGetTextureBlendMode(textures['Back Panel'].blendModeIndex);

    return FittedBox(
      child: BackPanel(
        width: 250.0,
        height: 500.0,
        cornerRadius: 34.0,
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
              top: 15.0,
              left: 15.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Camera(
                    diameter: 40.0,
                    lenseDiameter: 10.0,
                    trimWidth: 2.5,
                    trimColor: backPanelColor,
                    hasElevation: true,
                    backPanelColor: backPanelColor,
                  ),
                  SizedBox(height: 8.0),
                  Microphone(),
                  SizedBox(height: 8.0),
                  Flash(diameter: 15.0),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
