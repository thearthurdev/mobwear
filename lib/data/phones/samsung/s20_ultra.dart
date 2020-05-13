import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/brand_icons.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel_gradient.dart';
import 'package:mobwear/widgets/phone_widgets/button.dart';
import 'package:mobwear/widgets/phone_widgets/camera.dart';
import 'package:mobwear/widgets/phone_widgets/camera_bump.dart';
import 'package:mobwear/widgets/phone_widgets/flash.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class S20Ultra extends StatelessWidget {
  static final int phoneIndex = 17;
  static final int phoneID = 0217;
  static final int phoneBrandIndex = 1;
  static const String phoneBrand = 'Samsung';
  static const String phoneModel = 'Galaxy';
  static const String phoneName = 'Galaxy S20 Ultra';

  static List<Button> leftButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.right : ButtonPosition.left;

    return [
      Button(
        height: 70.0,
        yAlignment: -0.6,
        position: position,
        phoneID: phoneID,
      ),
      Button(
        height: 40.0,
        yAlignment: -0.2,
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
    screenWidth: 235.0,
    screenHeight: 510.0,
    horizontalPadding: 12.0,
    verticalPadding: 18.0,
    cornerRadius: 26.0,
    innerCornerRadius: 22.0,
    bezelsWidth: 2.0,
    screenAlignment: Alignment(0.0, -0.26),
    rightButtons: leftButtons(true),
    screenItems: <Widget>[
      Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Camera(
            diameter: 15.0,
            lenseDiameter: 5.0,
            trimWidth: 0.0,
          ),
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
    Color cameraBumpColor = colors['Camera Bump'];
    Color logoColor = colors['Samsung Logo'];
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
      diameter: 20.0,
      trimWidth: 3.0,
      lenseDiameter: 8.0,
      trimColor: Colors.grey[900],
    );

    CameraBump cameraBump = CameraBump(
      width: 100.0,
      height: 100.0,
      borderWidth: 0.3,
      cornerRadius: 14.0,
      cameraBumpPartsPadding: 2.0,
      elevationSpreadRadius: 0.3,
      hasElevation: false,
      cameraBumpColor: cameraBumpColor,
      backPanelColor: backPanelColor,
      texture: cameraBumpTexture,
      textureBlendColor: cameraBumpTextureBlendColor,
      textureBlendMode: cameraBumpTextureBlendMode,
      borderColor: Colors.black.withOpacity(0.03),
      cameraBumpParts: [
        Positioned(
          top: 8.0,
          left: 6.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              camera,
              SizedBox(height: 30.0),
              Camera(
                diameter: 26.0,
                trimWidth: 3.0,
                lenseDiameter: 8.0,
                trimColor: Colors.grey[900],
              ),
            ],
          ),
        ),
        Positioned(
          top: 12.0,
          right: 10.0,
          child: Column(
            children: <Widget>[
              Flash(diameter: 10.0),
              SizedBox(height: 39.0),
              camera,
            ],
          ),
        ),
      ],
    );

    return FittedBox(
      child: BackPanel(
        width: 235.0,
        height: 510.0,
        cornerRadius: 26.0,
        bezelsWidth: 1.5,
        backPanelColor: backPanelColor,
        bezelsColor: bezelsColor,
        texture: backPanelTexture,
        textureBlendColor: backPanelTextureBlendColor,
        textureBlendMode: backPanelTextureBlendMode,
        leftButtons: leftButtons(false),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: BackPanelGradient(
                width: 230.0,
                height: 506.0,
                cornerRadius: 24.0,
                stops: [0.0, 0.04, 0.08, 0.2, 0.8, 0.92, 0.96, 1.0],
                backPanelColor: backPanelColor,
              ),
            ),
            Positioned(
              top: 22.0,
              left: 22.0,
              child: CameraBump(
                width: 105.0,
                height: 146.0,
                borderWidth: 2.0,
                cornerRadius: 18.0,
                effectCornerRadius: 14.0,
                cameraBumpPartsPadding: 0.0,
                padding: 0.0,
                hasEffect: false,
                elevationSpreadRadius: 0.1,
                backPanelColor: backPanelColor,
                cameraBumpColor: backPanelColor,
                borderColor: backPanelColor,
                cameraBumpParts: <Widget>[
                  Container(
                    width: 105.0,
                    height: 160.0,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(17.0),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
                        child: cameraBump,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Camera(
                              width: 24.0,
                              height: 30.0,
                              cornerRadius: 6.0,
                              trimWidth: 0.5,
                              lenseWidth: 12,
                              lenseHeight: 18.0,
                              lenseCornerRadius: 4.0,
                              elevation: 0.5,
                              trimColor: Colors.black,
                              lenseColor: Colors.blueGrey[800],
                            ),
                            SizedBox(width: 14.0),
                            Material(
                              type: MaterialType.transparency,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'SPACE\nZOOM',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: kEstimateColorFromColorBrightness(
                                          backPanelColor,
                                          lightColor: Colors.white12,
                                          darkColor: Colors.black12),
                                      fontSize: 6.0,
                                      height: 1.0,
                                    ),
                                  ),
                                  Text(
                                    '100X',
                                    style: TextStyle(
                                      color: kEstimateColorFromColorBrightness(
                                          backPanelColor,
                                          lightColor: Colors.white12,
                                          darkColor: Colors.black12),
                                      fontSize: 16.0,
                                      letterSpacing: -0.5,
                                      fontFamily: 'Righteous',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment(-0.150, 0.6),
              child: Icon(
                BrandIcons.samsung3,
                color: logoColor,
                size: 54.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
