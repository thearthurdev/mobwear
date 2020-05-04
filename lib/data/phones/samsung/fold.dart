import 'package:flutter/material.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel.dart';
import 'package:mobwear/widgets/phone_widgets/back_panel_gradient.dart';
import 'package:mobwear/widgets/phone_widgets/button.dart';
import 'package:mobwear/widgets/phone_widgets/camera.dart';
import 'package:mobwear/widgets/phone_widgets/camera_bump.dart';
import 'package:mobwear/widgets/phone_widgets/flash.dart';
import 'package:mobwear/widgets/phone_widgets/screen.dart';
import 'package:mobwear/widgets/phone_widgets/speaker.dart';
import 'package:provider/provider.dart';

class Fold extends StatelessWidget {
  static final int phoneIndex = 11;
  static final int phoneID = 0211;
  static final int phoneBrandIndex = 1;
  static const String phoneBrand = 'Samsung';
  static const String phoneModel = 'Galaxy';
  static const String phoneName = 'Galaxy Fold';

  static List<Button> leftButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.right : ButtonPosition.left;

    return [
      Button(
        height: 70.0,
        yAlignment: -0.7,
        position: position,
        phoneID: phoneID,
      ),
      Button(
        height: 40.0,
        yAlignment: -0.3,
        position: position,
        phoneID: phoneID,
      ),
    ];
  }

  static Camera camera1 = Camera(
    diameter: 8.0,
    lenseColor: Colors.grey[700],
    trimWidth: 2.0,
    trimColor: Colors.grey[850],
  );

  final Widget front = FittedBox(
    child: Container(
      width: 376.0,
      height: 513.0,
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              BackPanel(
                width: 180.0,
                height: 510.0,
                backPanelColor: Colors.black,
                bezelsColor: Colors.grey[900],
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(24.0),
                  right: Radius.circular(6.0),
                ),
              ),
              BackPanel(
                width: 180.0,
                height: 510.0,
                backPanelColor: Colors.black,
                bezelsColor: Colors.grey[900],
                rightButtons: leftButtons(true),
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(6.0),
                  right: Radius.circular(24.0),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment(-0.3, 0.0),
            child: Screen(
              phoneName: phoneName,
              phoneModel: phoneModel,
              phoneBrand: phoneBrand,
              phoneID: phoneID,
              screenWidth: 336.0,
              screenHeight: 486.0,
              horizontalPadding: 1.0,
              verticalPadding: 1.0,
              cornerRadius: 24.0,
              innerCornerRadius: 16.0,
              bezelsWidth: 0.0,
              screenAlignment: Alignment.center,
              screenItems: <Widget>[
                Align(
                  alignment: Alignment(1.0, -1.02),
                  child: Container(
                    width: 130.0,
                    height: 30.0,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(18.0),
                        topRight: Radius.circular(14.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(width: 8.0),
                        camera1,
                        SizedBox(width: 12.0),
                        camera1,
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
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
    Color frontPanelColor = colors['Front Panel'];
    Color screen = colors['Screen'];
    // Color logoColor = colors['Samsung Logo'];
    Color backBezelsColor = colors['Back Panel Bezels'];
    Color frontBezelsColor = colors['Front Panel Bezels'];

    String cameraBumpTexture = textures['Camera Bump'].asset;
    Color cameraBumpTextureBlendColor = textures['Camera Bump'].blendColor;
    BlendMode cameraBumpTextureBlendMode =
        kGetTextureBlendMode(textures['Camera Bump'].blendModeIndex);

    String backPanelTexture = textures['Back Panel'].asset;
    Color backPanelTextureBlendColor = textures['Back Panel'].blendColor;
    BlendMode backPanelTextureBlendMode =
        kGetTextureBlendMode(textures['Back Panel'].blendModeIndex);

    String frontPanelTexture = textures['Front Panel'].asset;
    Color frontPanelTextureBlendColor = textures['Front Panel'].blendColor;
    BlendMode frontPanelTextureBlendMode =
        kGetTextureBlendMode(textures['Front Panel'].blendModeIndex);

    String screenTexture = textures['Screen'].asset;
    Color screenTextureBlendColor = textures['Screen'].blendColor;
    BlendMode screenTextureBlendMode =
        kGetTextureBlendMode(textures['Screen'].blendModeIndex);

    Camera camera = Camera(
      diameter: 20.0,
      trimWidth: 3.0,
      lenseDiameter: 8.0,
      trimColor: Colors.grey[900],
    );

    CameraBump cameraBump = CameraBump(
      width: 35.0,
      height: 105.0,
      borderWidth: 1.5,
      cameraBumpPartsPadding: 2.0,
      elevationSpreadRadius: 0.3,
      cornerRadius: 12.0,
      cameraBumpColor: cameraBumpColor,
      backPanelColor: backPanelColor,
      texture: cameraBumpTexture,
      textureBlendColor: cameraBumpTextureBlendColor,
      textureBlendMode: cameraBumpTextureBlendMode,
      borderColor: cameraBumpTexture == null
          ? backPanelColor.computeLuminance() > 0.335
              ? Colors.grey[400].withOpacity(0.7)
              : Colors.grey[700].withOpacity(0.7)
          : Colors.transparent,
      cameraBumpParts: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              camera,
              camera,
              camera,
            ],
          ),
        ),
      ],
    );

    bool isEditPageOpen =
        Provider.of<CustomizationProvider>(context).isEditPageOpen;

    return FittedBox(
      child: Container(
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              BackPanel(
                width: 180.0,
                height: 510.0,
                bezelsWidth: 0.5,
                backPanelColor: backPanelColor,
                bezelsColor: backBezelsColor,
                texture: backPanelTexture,
                textureBlendColor: backPanelTextureBlendColor,
                textureBlendMode: backPanelTextureBlendMode,
                leftButtons: leftButtons(false),
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(24.0),
                  right: Radius.circular(6.0),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: BackPanelGradient(
                        width: 200.0,
                        height: 510.0,
                        stops: [0.0, 0.02, 0.06, 0.2, 0.8, 0.94, 0.98, 1.0],
                        backPanelColor: backPanelColor,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(24.0),
                          right: Radius.circular(6.0),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 30.0,
                      left: 24.0,
                      child: cameraBump,
                    ),
                    Positioned(
                      top: 142.0,
                      left: 36.0,
                      child: Flash(diameter: 10.0),
                    ),
                  ],
                ),
              ),
              isEditPageOpen
                  ? BackPanel(
                      width: 180.0,
                      height: 510.0,
                      bezelsWidth: 0.5,
                      backPanelColor: frontPanelColor,
                      bezelsColor: frontBezelsColor,
                      texture: frontPanelTexture,
                      textureBlendColor: frontPanelTextureBlendColor,
                      textureBlendMode: frontPanelTextureBlendMode,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(6.0),
                        right: Radius.circular(24.0),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: BackPanelGradient(
                              width: 200.0,
                              height: 510.0,
                              stops: [
                                0.0,
                                0.02,
                                0.06,
                                0.2,
                                0.8,
                                0.94,
                                0.98,
                                1.0
                              ],
                              backPanelColor: backPanelColor,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(6.0),
                                right: Radius.circular(24.0),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: BackPanel(
                              width: 150.0,
                              height: 350.0,
                              cornerRadius: 18.0,
                              backPanelColor: screen,
                              texture: screenTexture,
                              textureBlendColor: screenTextureBlendColor,
                              textureBlendMode: screenTextureBlendMode,
                              noShadow: true,
                              noButtons: true,
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.0, -0.855),
                            child: Speaker(),
                          ),
                          Align(
                            alignment: Alignment(0.7, -0.87),
                            child: Camera(
                              diameter: 16.0,
                              trimWidth: 1.5,
                              lenseDiameter: 6.0,
                              trimColor: Colors.grey[900],
                            ),
                          ),
                        ],
                      ),
                    )
                  : BackPanel(
                      width: 6.0,
                      height: 500.0,
                      bezelsWidth: 0.5,
                      backPanelColor: Colors.grey[900],
                      bezelsColor: Colors.grey[900],
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(0.0),
                        right: Radius.circular(16.0),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: BackPanelGradient(
                              width: 8.0,
                              height: 500.0,
                              stops: [
                                0.0,
                                0.02,
                                0.06,
                                0.2,
                                0.8,
                                0.94,
                                0.98,
                                1.0
                              ],
                              backPanelColor: backPanelColor,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(0.0),
                                right: Radius.circular(16.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
