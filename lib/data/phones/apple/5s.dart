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
import 'package:provider/provider.dart';

class IPhone5S extends StatelessWidget {
  static final int phoneIndex = 4;
  static final int phoneID = 0104;
  static final int phoneBrandIndex = 0;
  static const String phoneBrand = 'Apple';
  static const String phoneModel = 'iPhone';
  static const String phoneName = 'iPhone 5S';

  static String boxColorKey = 'Bezels';

  static List<Button> topButtons(bool invert) {
    double xAlignment = invert ? 0.67 : -0.67;

    return [
      Button(
        height: 2.5,
        width: 35.0,
        xAlignment: xAlignment,
        position: ButtonPosition.top,
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
        height: 22.0,
        yAlignment: -0.73,
        position: position,
        phoneID: phoneID,
        boxColorKey: boxColorKey,
      ),
      Button(
        height: 18.0,
        yAlignment: -0.54,
        position: position,
        phoneID: phoneID,
        boxColorKey: boxColorKey,
      ),
      Button(
        height: 18.0,
        yAlignment: -0.36,
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
    screenHeight: 470.0,
    horizontalPadding: 26.0,
    verticalPadding: 140.0,
    bezelsWidth: 2.0,
    cornerRadius: 32.0,
    innerCornerRadius: 0.0,
    screenFaceColor: Colors.white,
    topButtons: topButtons(true),
    leftButtons: rightButtons(true),
    screenItems: <Widget>[
      Align(
        alignment: Alignment(0.0, 0.945),
        child: IPhoneHomeButton(
          phoneID: phoneID,
          diameter: 45.0,
          squareMargin: 27.0,
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

    Color topBottomPanelColor = colors['Top & Bottom Panel'];
    Color middlePanelColor = colors['Middle Panel'];
    Color logoColor = colors['Apple Logo'];
    Color textMarksColor = colors['Texts & Markings'];
    Color bezelsColor = colors['Bezels'];

    String topBottomPanelTexture = textures['Top & Bottom Panel'].asset;
    Color topBottomPanelTextureBlendColor =
        textures['Top & Bottom Panel'].blendColor;
    BlendMode topBottomPanelTextureBlendMode =
        kGetTextureBlendMode(textures['Top & Bottom Panel'].blendModeIndex);

    String middlePanelTexture = textures['Middle Panel'].asset;
    Color middlePanelTextureBlendColor = textures['Middle Panel'].blendColor;
    BlendMode middlePanelTextureBlendMode =
        kGetTextureBlendMode(textures['Middle Panel'].blendModeIndex);

    return FittedBox(
      child: BackPanel(
        height: 470.0,
        cornerRadius: 32.0,
        backPanelColor: topBottomPanelColor,
        bezelsColor: bezelsColor,
        texture: topBottomPanelTexture,
        textureBlendColor: topBottomPanelTextureBlendColor,
        textureBlendMode: topBottomPanelTextureBlendMode,
        topButtons: topButtons(false),
        rightButtons: rightButtons(false),
        bezelsWidth: 2.0,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: BackPanel(
                height: 375.0,
                width: 250.0,
                cornerRadius: 0.0,
                noShadow: true,
                noButtons: true,
                backPanelColor: middlePanelColor,
                texture: middlePanelTexture,
                textureBlendColor: middlePanelTextureBlendColor,
                textureBlendMode: middlePanelTextureBlendMode,
              ),
            ),
            Align(
              alignment: Alignment(0.0, -0.6),
              child: Icon(
                BrandIcons.apple,
                color: logoColor,
                size: 60.0,
              ),
            ),
            Positioned(
              top: 14.0,
              left: 20.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Camera(diameter: 25.0),
                  SizedBox(width: 6.0),
                  Microphone(diameter: 4.5),
                  SizedBox(width: 6.0),
                  Flash(
                    diameter: 12.0,
                    height: 20.0,
                  ),
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
