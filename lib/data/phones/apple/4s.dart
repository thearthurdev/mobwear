import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/brand_icons.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/camera.dart';
import 'package:mobwear/widgets/phone_widgets/flash.dart';
import 'package:mobwear/widgets/phone_widgets/iPhone_home_button.dart';
import 'package:mobwear/widgets/phone_widgets/iPhone_text_marks.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:provider/provider.dart';

class IPhone4S extends StatelessWidget {
  static final int phoneIndex = 1;
  static final int phoneID = 0201;
  static final int phoneBrandIndex = 1;
  static const String phoneBrand = 'Apple';
  static const String phoneModel = 'iPhone';
  static const String phoneName = 'iPhone 4S';

  final Screen front = Screen(
    phoneName: phoneName,
    phoneModel: phoneModel,
    phoneBrand: phoneBrand,
    phoneID: phoneID,
    screenHeight: 450.0,
    horizontalPadding: 26.0,
    verticalPadding: 140.0,
    bezelsWidth: 2.0,
    cornerRadius: 36.0,
    innerCornerRadius: 0.0,
    bezelsColor: Color(0xFFEEEEEE),
    screenFaceColor: Colors.white,
    screenItems: <Widget>[
      Align(
        alignment: Alignment(0.0, 0.94),
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
        height: 450.0,
        cornerRadius: 36.0,
        backPanelColor: backPanelColor,
        bezelsColor: bezelsColor,
        texture: backPanelTexture,
        textureBlendColor: backPanelTextureBlendColor,
        textureBlendMode: backPanelTextureBlendMode,
        bezelsWidth: 2.0,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(0.0, -0.6),
              child: Icon(
                BrandIcons.apple,
                color: logoColor,
                size: 60.0,
              ),
            ),
            Positioned(
              top: 25.0,
              left: 25.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Camera(
                    diameter: 25.0,
                  ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
