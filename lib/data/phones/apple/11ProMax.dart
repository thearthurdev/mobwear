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

class IPhone11ProMax extends StatelessWidget {
  final int phoneIndex = 4;
  final int phoneBrandIndex = 1;
  static const String phoneBrand = 'Apple';
  static const String phoneModel = 'iPhone';
  static const String phoneName = 'iPhone 11 Pro Max';

  final Screen front = Screen(
    hasNotch: true,
    phoneBrand: phoneBrand,
    phoneModel: phoneModel,
    phoneName: phoneName,
  );

  get getPhoneName => phoneName;
  get getPhoneFront => front;
  get getPhoneBrand => phoneBrand;

  @override
  Widget build(BuildContext context) {
    var colors = Provider.of<PhonesData>(context).iPhones[4].colors;

    Color cameraBumpColor = colors['Camera Bump'];
    Color backPanelColor = colors['Back Panel'];
    Color logoColor = colors['Apple Logo'];

    CameraBump cameraBump = CameraBump(
      width: 100.0,
      height: 100.0,
      cameraBumpColor: cameraBumpColor,
      backPanelColor: backPanelColor,
      cameraBumpParts: [
        Positioned(
          left: 3.0,
          top: 3.0,
          child: Camera(),
        ),
        Positioned(
          left: 3.0,
          bottom: 3.0,
          child: Camera(),
        ),
        Positioned(
          right: 3.0,
          top: 22.5,
          child: Camera(),
        ),
        Positioned(
          right: 12.0,
          top: 4.0,
          child: Flash(diameter: 15.0),
        ),
        Positioned(
          right: 17.0,
          bottom: 9.0,
          child: Microphone(),
        ),
      ],
    );

    return FittedBox(
      child: BackPanel(
        width: 250.0,
        height: 500.0,
        cornerRadius: 30.0,
        backPanelColor: backPanelColor,
        bezelColor: backPanelColor,
        child: Stack(
          children: <Widget>[
            Container(
              width: 250.0,
              height: 500.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    backPanelColor.computeLuminance() > 0.335
                        ? Colors.black12
                        : Colors.black26
                  ],
                  begin: FractionalOffset(0.5, 0.0),
                  end: FractionalOffset(0.0, 0.5),
                ),
              ),
            ),
            Positioned(
              top: 5.0,
              left: 5.0,
              child: cameraBump,
            ),
            Align(
              alignment: Alignment.center,
              child: Icon(
                BrandIcons.apple,
                color: logoColor,
                size: 60.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
