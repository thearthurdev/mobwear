import 'package:flutter/material.dart';
import 'package:mobware/custom_icons/brand_icons.dart';
import 'package:mobware/providers/phones_data.dart';
import 'package:mobware/widgets/phone_parts/back_panel.dart';
import 'package:mobware/widgets/phone_parts/camera.dart';
import 'package:mobware/widgets/phone_parts/camera_bump.dart';
import 'package:mobware/widgets/phone_parts/flash.dart';
import 'package:mobware/widgets/phone_parts/microphone.dart';
import 'package:mobware/widgets/phone_parts/screen.dart';
import 'package:provider/provider.dart';

class Pixel4XL extends StatelessWidget {
  final int phoneIndex = 4;
  final int phoneBrandIndex = 0;
  static const String phoneBrand = 'Google';
  static const String phoneModel = 'Pixel';
  static const String phoneName = 'Pixel 4 XL';

  final Screen front = Screen(
    bezelVertical: 40.0,
    screenAlignment: Alignment(0.0, 0.6),
    phoneBrand: phoneBrand,
    phoneModel: phoneModel,
    phoneName: phoneName,
  );

  get getPhoneName => phoneName;
  get getPhoneFront => front;
  get getPhoneBrand => phoneBrand;

  @override
  Widget build(BuildContext context) {
    var colors = Provider.of<PhonesData>(context).pixels[4].colors;

    Color cameraBumpColor = colors['Camera Bump'];
    Color backPanelColor = colors['Back Panel'];
    Color logoColor = colors['Google Logo'];
    Color bezelColor = colors['Bezels'];

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
