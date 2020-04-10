import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/brand_icons.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/camera.dart';
import 'package:mobwear/widgets/phone_widgets/flash.dart';
import 'package:mobwear/widgets/phone_widgets/iPhone_home_button.dart';
import 'package:mobwear/widgets/phone_widgets/iPhone_text_marks.dart';
import 'package:mobwear/widgets/phone_widgets/microphone.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:provider/provider.dart';

class IPhone5 extends StatelessWidget {
  static final int phoneIndex = 2;
  static final int phoneID = 0102;
  static final int phoneBrandIndex = 0;
  static const String phoneBrand = 'Apple';
  static const String phoneModel = 'iPhone';
  static const String phoneName = 'iPhone 5';

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
    screenItems: <Widget>[
      Align(
        alignment: Alignment(0.0, 0.945),
        child: IPhoneHomeButton(
          phoneID: phoneID,
          diameter: 45.0,
          squareMargin: 27.0,
          trimWidth: 1.5,
          hasSquare: true,
          trimColor: Colors.black.withOpacity(0.03),
          squareColor: Colors.black.withOpacity(0.1),
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
