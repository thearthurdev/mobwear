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
import 'package:mobwear/data/models/texture_model.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ZFlip extends StatelessWidget {
  static final int phoneIndex = 14;
  static final int phoneID = 0214;
  static final int phoneBrandIndex = 1;
  static const String phoneBrand = 'Samsung';
  static const String phoneModel = 'Galaxy';
  static const String phoneName = 'Galaxy Z Flip';

  static String boxColorKey = 'Top Panel Bezels';

  static List<Button> leftButtons(bool invert) {
    ButtonPosition position =
        invert ? ButtonPosition.right : ButtonPosition.left;

    return [
      Button(
        height: 60.0,
        yAlignment: -0.15,
        position: position,
        phoneID: phoneID,
        boxColorKey: boxColorKey,
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
      width: 235.0,
      height: 515.0,
      child: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BackPanel(
                    width: 230.0,
                    height: 256.0,
                    backPanelColor: Colors.black,
                    bezelsColor: Colors.grey[900],
                    rightButtons: leftButtons(true),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24.0),
                      bottom: Radius.circular(6.0),
                    ),
                  ),
                  BackPanel(
                    width: 230.0,
                    height: 256.0,
                    noButtons: true,
                    backPanelColor: Colors.black,
                    bezelsColor: Colors.grey[900],
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(6.0),
                      bottom: Radius.circular(24.0),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment(-0.15, 0.0),
              child: Screen(
                phoneName: phoneName,
                phoneModel: phoneModel,
                phoneBrand: phoneBrand,
                phoneID: phoneID,
                screenWidth: 210.0,
                screenHeight: 490.0,
                horizontalPadding: 1.0,
                verticalPadding: 1.0,
                cornerRadius: 18.0,
                innerCornerRadius: 20.0,
                bezelsWidth: 0.0,
                screenAlignment: Alignment(0.0, 0.0),
                screenItems: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Camera(
                        diameter: 15.0,
                        lenseDiameter: 5.0,
                        trimWidth: 0.0,
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

    Color cameraBumpColor = colors['Camera Bump'];
    Color topPanelColor = colors['Top Panel'];
    Color bottomPanelColor = colors['Bottom Panel'];
    // Color logoColor = colors['Samsung Logo'];
    Color topBezelsColor = colors['Top Panel Bezels'];
    Color bottomBezelsColor = colors['Bottom Panel Bezels'];

    String cameraBumpTexture = textures['Camera Bump'].asset;
    Color cameraBumpTextureBlendColor = textures['Camera Bump'].blendColor;
    BlendMode cameraBumpTextureBlendMode =
        kGetTextureBlendMode(textures['Camera Bump'].blendModeIndex);

    String topPanelTexture = textures['Top Panel'].asset;
    Color topPanelTextureBlendColor = textures['Top Panel'].blendColor;
    BlendMode topPanelTextureBlendMode =
        kGetTextureBlendMode(textures['Top Panel'].blendModeIndex);

    String bottomPanelTexture = textures['Bottom Panel'].asset;
    Color bottomPanelTextureBlendColor = textures['Bottom Panel'].blendColor;
    BlendMode bottomPanelTextureBlendMode =
        kGetTextureBlendMode(textures['Bottom Panel'].blendModeIndex);

    Camera camera = Camera(
      diameter: 20.0,
      trimWidth: 3.0,
      lenseDiameter: 8.0,
      trimColor: Colors.grey[900],
    );

    CameraBump cameraBump = CameraBump(
      width: 60.0,
      height: 30.0,
      borderWidth: 1.5,
      cameraBumpPartsPadding: 2.0,
      elevationSpreadRadius: 0.3,
      cornerRadius: 12.0,
      padding: 2.0,
      cameraBumpColor: cameraBumpColor,
      backPanelColor: topPanelColor,
      texture: cameraBumpTexture,
      textureBlendColor: cameraBumpTextureBlendColor,
      textureBlendMode: cameraBumpTextureBlendMode,
      borderColor: cameraBumpTexture == null
          ? topPanelColor.computeLuminance() > 0.335
              ? Colors.grey[400].withOpacity(0.7)
              : Colors.grey[700].withOpacity(0.7)
          : Colors.transparent,
      cameraBumpParts: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              camera,
              camera,
            ],
          ),
        ),
      ],
    );

    return FittedBox(
      child: Container(
        height: 516.0,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: BackPanel(
                  width: 230.0,
                  height: 256.8,
                  bezelsWidth: 0.5,
                  backPanelColor: topBezelsColor,
                  bezelsColor: topBezelsColor,
                  leftButtons: leftButtons(false),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.0),
                    bottom: Radius.circular(6.0),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Align(
                        alignment: Alignment(0.0, -0.98),
                        child: BackPanel(
                          height: 244.0,
                          bezelsWidth: 0.5,
                          noButtons: true,
                          noShadow: true,
                          backPanelColor: topPanelColor,
                          bezelsColor: topBezelsColor,
                          texture: topPanelTexture,
                          textureBlendColor: topPanelTextureBlendColor,
                          textureBlendMode: topPanelTextureBlendMode,
                          leftButtons: leftButtons(false),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24.0),
                            bottom: Radius.circular(6.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: BackPanelGradient(
                          stops: [0.0, 0.02, 0.06, 0.2, 0.8, 0.94, 0.98, 1.0],
                          backPanelColor: topPanelColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24.0),
                            bottom: Radius.circular(6.0),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16.0,
                        left: 16.0,
                        child: cameraBump,
                      ),
                      Positioned(
                        top: 27.0,
                        left: 82.0,
                        child: Flash(
                          width: 8.0,
                          height: 10.0,
                        ),
                      ),
                      Positioned(
                        top: 16.0,
                        right: 16.0,
                        child: Container(
                          width: 70.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: topPanelTexture == null
                                ? kEstimateColorFromColorBrightness(
                                    topPanelColor,
                                    lightColor: Colors.white.withOpacity(0.03),
                                    darkColor: Colors.black.withOpacity(0.03))
                                : topPanelColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: BackPanel(
                  width: 230.0,
                  height: 256.8,
                  bezelsWidth: 0.5,
                  backPanelColor: bottomBezelsColor,
                  bezelsColor: bottomBezelsColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(6.0),
                    bottom: Radius.circular(24.0),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Align(
                        alignment: Alignment(0.0, 0.98),
                        child: BackPanel(
                          height: 244.0,
                          bezelsWidth: 0.5,
                          noButtons: true,
                          noShadow: true,
                          backPanelColor: bottomPanelColor,
                          bezelsColor: bottomBezelsColor,
                          texture: bottomPanelTexture,
                          textureBlendColor: bottomPanelTextureBlendColor,
                          textureBlendMode: bottomPanelTextureBlendMode,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(6.0),
                            bottom: Radius.circular(24.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: BackPanelGradient(
                          stops: [0.0, 0.02, 0.06, 0.2, 0.8, 0.94, 0.98, 1.0],
                          backPanelColor: topPanelColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(6.0),
                            bottom: Radius.circular(24.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
