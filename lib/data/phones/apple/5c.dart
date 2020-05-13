import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/brand_icons.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/button.dart';
import 'package:mobwear/widgets/phone_widgets/camera.dart';
import 'package:mobwear/widgets/phone_widgets/flash.dart';
import 'package:mobwear/widgets/phone_widgets/iPhone_home_button.dart';
import 'package:mobwear/widgets/phone_widgets/iPhone_text_marks.dart';
import 'package:mobwear/widgets/phone_widgets/microphone.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class IPhone5C extends StatelessWidget {
  static final int phoneIndex = 3;
  static final int phoneID = 0103;
  static final int phoneBrandIndex = 0;
  static const String phoneBrand = 'Apple';
  static const String phoneModel = 'iPhone';
  static const String phoneName = 'iPhone 5C';

  static List<Button> topButtons(bool invert) {
    double xAlignment = invert ? 0.67 : -0.67;

    return [
      Button(
        height: 2.5,
        width: 35.0,
        xAlignment: xAlignment,
        position: ButtonPosition.top,
        phoneID: phoneID,
      ),
    ];
  }

  static List<Button> rightButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.left : ButtonPosition.right;

    return [
      Button(
        height: 18.0,
        yAlignment: -0.73,
        position: position,
        phoneID: phoneID,
      ),
      Button(
        height: 35.0,
        yAlignment: -0.58,
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
    screenHeight: 470.0,
    horizontalPadding: 26.0,
    verticalPadding: 140.0,
    bezelsWidth: 3.0,
    cornerRadius: 32.0,
    innerCornerRadius: 0.0,
    boxColorKey: 'Back Panel',
    topButtons: topButtons(true),
    leftButtons: rightButtons(true),
    screenItems: <Widget>[
      Align(
        alignment: Alignment(0.0, 0.945),
        child: IPhoneHomeButton(
          phoneID: phoneID,
          diameter: 45.0,
          squareMargin: 27.0,
          trimWidth: 1.5,
          hasSquare: true,
          buttonColor: Colors.black,
          trimColor: Colors.white.withOpacity(0.05),
          squareColor: Colors.white.withOpacity(0.3),
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
    Color logoColor = colors['Apple Logo'];
    Color textMarksColor = colors['Texts & Markings'];

    String backPanelTexture = textures['Back Panel'].asset;
    Color backPanelTextureBlendColor = textures['Back Panel'].blendColor;
    BlendMode backPanelTextureBlendMode =
        kGetTextureBlendMode(textures['Back Panel'].blendModeIndex);

    return FittedBox(
      child: BackPanel(
        height: 470.0,
        cornerRadius: 32.0,
        bezelsColor: backPanelColor,
        backPanelColor: backPanelColor,
        texture: backPanelTexture,
        textureBlendColor: backPanelTextureBlendColor,
        textureBlendMode: backPanelTextureBlendMode,
        topButtons: topButtons(false),
        rightButtons: rightButtons(false),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(0.0, -0.52),
              child: Icon(
                BrandIcons.apple,
                color: logoColor,
                size: 60.0,
              ),
            ),
            Positioned(
              top: 18.0,
              left: 22.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Camera(diameter: 25.0),
                  SizedBox(width: 6.0),
                  Microphone(diameter: 4.5),
                  SizedBox(width: 6.0),
                  Flash(diameter: 12.0),
                ],
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.7),
              child: IPhoneTextMarks(
                color: textMarksColor,
                idNumbersText: true,
                isSingleLine: true,
                phoneID: phoneID.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
