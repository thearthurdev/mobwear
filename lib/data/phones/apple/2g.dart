import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/brand_icons.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/camera.dart';
import 'package:mobwear/widgets/phone_widgets/iPhone_home_button.dart';
import 'package:mobwear/widgets/phone_widgets/iPhone_text_marks.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:provider/provider.dart';

class IPhone2G extends StatelessWidget {
  static final int phoneIndex = 0;
  static final int phoneID = 0200;
  static final int phoneBrandIndex = 1;
  static const String phoneBrand = 'Apple';
  static const String phoneModel = 'iPhone';
  static const String phoneName = 'iPhone 2G';

  final Screen front = Screen(
    phoneName: phoneName,
    phoneModel: phoneModel,
    phoneBrand: phoneBrand,
    phoneID: phoneID,
    screenHeight: 450.0,
    horizontalPadding: 26.0,
    verticalPadding: 140.0,
    bezelsWidth: 8.0,
    cornerRadius: 36.0,
    innerCornerRadius: 0.0,
    bezelsColor: Color(0xFFBBC3C7),
    screenItems: <Widget>[
      Align(
        alignment: Alignment(0.0, 0.96),
        child: IPhoneHomeButton(
          phoneID: phoneID,
          diameter: 45.0,
          squareMargin: 27.0,
          hasSquare: true,
          buttonColor: Colors.black,
          trimColor: Colors.white.withOpacity(0.05),
          squareColor: Colors.white.withOpacity(0.5),
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

    Color topPanelColor = colors['Top Panel'];
    Color bottomPanelColor = colors['Bottom Panel'];
    Color logoColor = colors['Apple Logo'];
    Color textMarksColor = colors['Texts & Markings'];

    String topPanelTexture = textures['Top Panel'].asset;
    Color topPanelTextureBlendColor = textures['Top Panel'].blendColor;
    BlendMode topPanelTextureBlendMode =
        kGetTextureBlendMode(textures['Top Panel'].blendModeIndex);

    String bottomPanelTexture = textures['Bottom Panel'].asset;
    Color bottomPanelTextureBlendColor = textures['Bottom Panel'].blendColor;
    BlendMode bottomPanelTextureBlendMode =
        kGetTextureBlendMode(textures['Bottom Panel'].blendModeIndex);

    return FittedBox(
      child: BackPanel(
        height: 450.0,
        cornerRadius: 36.0,
        backPanelColor: Colors.transparent,
        bezelsWidth: 0.0,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: BackPanel(
                height: 352.0,
                noShadow: true,
                backPanelColor: topPanelColor,
                texture: topPanelTexture,
                textureBlendColor: topPanelTextureBlendColor,
                textureBlendMode: topPanelTextureBlendMode,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36.0),
                  topRight: Radius.circular(36.0),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BackPanel(
                height: 100.0,
                noShadow: true,
                backPanelColor: bottomPanelColor,
                texture: bottomPanelTexture,
                textureBlendColor: bottomPanelTextureBlendColor,
                textureBlendMode: bottomPanelTextureBlendMode,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36.0),
                  bottomRight: Radius.circular(36.0),
                ),
              ),
            ),
            Positioned(
              top: 25.0,
              left: 25.0,
              child: Camera(
                diameter: 20.0,
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
            Align(
              alignment: Alignment(0.0, 0.4),
              child: IPhoneTextMarks(
                color: textMarksColor,
                ceMarkings: false,
                storageText: true,
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
