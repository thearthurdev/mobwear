import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/brand_icons.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/button.dart';
import 'package:mobwear/widgets/phone_widgets/camera.dart';
import 'package:mobwear/widgets/phone_widgets/flash.dart';
import 'package:mobwear/widgets/phone_widgets/iPhone_home_button.dart';
import 'package:mobwear/widgets/phone_widgets/iPhone_text_marks.dart';
import 'package:mobwear/widgets/phone_widgets/microphone.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:provider/provider.dart';

class IPhone7 extends StatelessWidget {
  static final int phoneIndex = 6;
  static final int phoneID = 0106;
  static final int phoneBrandIndex = 0;
  static const String phoneBrand = 'Apple';
  static const String phoneModel = 'iPhone';
  static const String phoneName = 'iPhone 7';

  static List<Button> leftButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.right : ButtonPosition.left;

    return [
      Button(
        height: 35.0,
        yAlignment: -0.53,
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
    boxColorKey: 'Back Panel',
    leftButtons: rightButtons(true),
    rightButtons: leftButtons(true),
    screenItems: <Widget>[
      Align(
        alignment: Alignment(0.0, 0.965),
        child: IPhoneHomeButton(
          phoneID: phoneID,
          boxColorKey: 'Back Panel',
          diameter: 38.0,
          buttonColor: Colors.black,
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
    // var textures = phonesBox.get(phoneID).textures;

    Color backPanelColor = colors['Back Panel'];
    Color logoColor = colors['Apple Logo'];
    Color textMarksColor = colors['Texts & Markings'];
    Color antennaBandCurvedColor = colors['Antenna Bands'];

    // String backPanelTexture = textures['Back Panel'].asset;
    // Color backPanelTextureBlendColor = textures['Back Panel'].blendColor;
    // BlendMode backPanelTextureBlendMode =
    //     kGetTextureBlendMode(textures['Back Panel'].blendModeIndex);

    Widget antennaBandCurved(Alignment alignment) {
      return Align(
        alignment: alignment,
        child: BackPanel(
          backPanelColor: Colors.transparent,
          noShadow: true,
          noButtons: true,
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
        bezelsColor: backPanelColor,
        leftButtons: leftButtons(false),
        rightButtons: rightButtons(false),
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
            Align(
              alignment: Alignment.center,
              child: BackPanel(
                backPanelColor: backPanelColor,
                noShadow: true,
                noButtons: true,
                cornerRadius: 0.0,
                width: 235.0,
                height: 430.0,
              ),
            ),
            Positioned(
              top: 12.0,
              left: 12.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Camera(
                    diameter: 40.0,
                    lenseDiameter: 12.0,
                    trimWidth: 3.0,
                    trimColor: Colors.black.withOpacity(0.3),
                    backPanelColor: backPanelColor,
                    hasElevation: true,
                  ),
                  SizedBox(width: 8.0),
                  Microphone(),
                  SizedBox(width: 8.0),
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
