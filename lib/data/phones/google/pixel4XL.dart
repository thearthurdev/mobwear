import 'package:flutter/material.dart';
import 'package:mobware/custom_icons/brand_icons.dart';
import 'package:mobware/providers/phones_customization_provider.dart';
import 'package:mobware/widgets/phone_widgets/back_panel.dart';
import 'package:mobware/widgets/phone_widgets/camera.dart';
import 'package:mobware/widgets/phone_widgets/camera_bump.dart';
import 'package:mobware/widgets/phone_widgets/flash.dart';
import 'package:mobware/widgets/phone_widgets/microphone.dart';
import 'package:mobware/widgets/phone_widgets/screen.dart';
import 'package:provider/provider.dart';

class Pixel4XL extends StatelessWidget {
  final int phoneIndex = 4;
  final int phoneBrandIndex = 0;
  static const String phoneBrand = 'Google';
  static const String phoneModel = 'Pixel';
  static const String phoneName = 'Pixel 4 XL';

  final Screen front = Screen(
    phoneName: phoneName,
    phoneModel: phoneModel,
    phoneBrand: phoneBrand,
    bezelVertical: 40.0,
    screenAlignment: Alignment(0.0, 0.6),
  );

  get getPhoneFront => front;
  get getPhoneName => phoneName;
  get getPhoneBrand => phoneBrand;

  @override
  Widget build(BuildContext context) {
    var colors =
        Provider.of<PhoneCustomizationProvider>(context).pixels[4].colors;
    var textures =
        Provider.of<PhoneCustomizationProvider>(context).pixels[4].textures;

    Color cameraBumpColor = colors['Camera Bump'];
    Color backPanelColor = colors['Back Panel'];
    Color logoColor = colors['Google Logo'];
    Color bezelColor = colors['Bezels'];

    String cameraBumpTexture = textures['Camera Bump'].asset;
    Color cameraBumpTextureBlendColor = textures['Camera Bump'].blendColor;
    BlendMode cameraBumpTextureBlendMode = textures['Camera Bump'].blendMode;
    String backPanelTexture = textures['Back Panel'].asset;
    Color backPanelTextureBlendColor = textures['Back Panel'].blendColor;
    BlendMode backPanelTextureBlendMode = textures['Back Panel'].blendMode;

    Camera camera = Camera(
      diameter: 28.0,
      trimWidth: 3.0,
      trimColor: Colors.grey[900],
    );

    CameraBump cameraBump = CameraBump(
      width: 80.0,
      height: 80.0,
      cameraBumpColor: cameraBumpColor,
      backPanelColor: backPanelColor,
      texture: cameraBumpTexture,
      textureBlendColor: cameraBumpTextureBlendColor,
      textureBlendMode: cameraBumpTextureBlendMode,
      cameraBumpPartsPadding: 2.0,
      cameraBumpParts: [
        Positioned(
          left: 5.0,
          top: 22.5,
          child: camera,
        ),
        Positioned(
          right: 5.0,
          top: 22.5,
          child: camera,
        ),
        Positioned(
          left: 32.5,
          bottom: 7.0,
          child: Flash(diameter: 15.0),
        ),
        Positioned(
          right: 17.0,
          bottom: 11.0,
          child: Microphone(),
        ),
        Positioned(
          left: 37.0,
          top: 10.0,
          child: Microphone(),
        ),
      ],
    );

    return FittedBox(
      child: BackPanel(
        cornerRadius: 30.0,
        bezelWidth: 4.0,
        backPanelColor: backPanelColor,
        bezelColor: bezelColor,
        texture: backPanelTexture,
        textureBlendColor: backPanelTextureBlendColor,
        textureBlendMode: backPanelTextureBlendMode,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26.0),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    backPanelColor.computeLuminance() > 0.335
                        ? Colors.black12
                        : Colors.black26
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(),
                  ),
                  Icon(
                    BrandIcons.google,
                    color: logoColor,
                    size: 30.0,
                  ),
                  SizedBox(height: 70.0),
                ],
              ),
            ),
            Positioned(
              top: 10.0,
              left: 10.0,
              child: cameraBump,
            ),
          ],
        ),
      ),
    );
  }
}
