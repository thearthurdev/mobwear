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

class IPhone6Plus extends StatelessWidget {
  static final int phoneIndex = 5;
  static final int phoneID = 0205;
  static final int phoneBrandIndex = 1;
  static const String phoneBrand = 'Apple';
  static const String phoneModel = 'iPhone';
  static const String phoneName = 'iPhone 6 Plus';

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
    bezelsSide: 'Back Panel',
    screenItems: <Widget>[
      Align(
        alignment: Alignment(0.0, 0.965),
        child: IPhoneHomeButton(
          phoneID: phoneID,
          bezelsSide: 'Back Panel',
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

    Color backPanelColor = colors['Back Panel'];
    Color logoColor = colors['Apple Logo'];
    Color textMarksColor = colors['Texts & Markings'];
    Color antennaBandCurvedColor = colors['Antenna Bands'];

    String backPanelTexture = textures['Back Panel'].asset;
    Color backPanelTextureBlendColor = textures['Back Panel'].blendColor;
    BlendMode backPanelTextureBlendMode =
        kGetTextureBlendMode(textures['Back Panel'].blendModeIndex);

    Widget antennaBandCurved(Alignment alignment) {
      return Align(
        alignment: alignment,
        child: BackPanel(
          backPanelColor: Colors.transparent,
          noShadow: true,
          width: 245.0,
          height: 42.0,
          bezelsWidth: 5.0,
          bezelsColor: antennaBandCurvedColor,
          borderRadius: alignment == Alignment.topCenter
              ? BorderRadius.only(
                  topLeft: Radius.circular(34.0),
                  topRight: Radius.circular(34.0),
                )
              : BorderRadius.only(
                  bottomLeft: Radius.circular(34.0),
                  bottomRight: Radius.circular(34.0),
                ),
        ),
      );
    }

    Container antennaBandHorizontal() {
      return Container(
        height: 5.0,
        width: double.infinity,
        color: antennaBandCurvedColor,
      );
    }

    return FittedBox(
      child: BackPanel(
        width: 250.0,
        height: 500.0,
        cornerRadius: 36.0,
        backPanelColor: backPanelColor,
        texture: backPanelTexture,
        textureBlendColor: backPanelTextureBlendColor,
        textureBlendMode: backPanelTextureBlendMode,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(0.0, -0.848),
              child: antennaBandHorizontal(),
            ),
            Align(
              alignment: Alignment(0.0, 0.848),
              child: antennaBandHorizontal(),
            ),
            antennaBandCurved(Alignment.topCenter),
            antennaBandCurved(Alignment.bottomCenter),
            Positioned(
              top: 8.0,
              left: 28.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Camera(
                    diameter: 28.0,
                    lenseDiameter: 12.0,
                    trimWidth: 3.0,
                    trimColor: Colors.black.withOpacity(0.3),
                  ),
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
              alignment: Alignment(0.0, 0.7),
              child: IPhoneTextMarks(
                color: textMarksColor,
                isSingleLine: true,
                idNumbersText: true,
                phoneID: phoneID.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
