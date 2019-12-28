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

class IPhone11 extends StatelessWidget {
  final int phoneIndex = 3;
  final int phoneBrandIndex = 1;
  static const String phoneBrand = 'Apple';
  static const String phoneModel = 'iPhone';
  static const String phoneName = 'iPhone 11';

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
    var colors = Provider.of<PhonesData>(context).iPhones[3].colors;

    Color cameraBumpColor = colors['Camera Bump'];
    Color backPanelColor = colors['Back Panel'];
    Color logoColor = colors['Apple Logo'];

    CameraBump cameraBump = CameraBump(
      width: 100.0,
      height: 100.0,
      cameraBumpColor: cameraBumpColor,
      backPanelColor: backPanelColor,
      isMatte: true,
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
          right: 10.0,
          top: 32.0,
          child: Flash(),
        ),
        Positioned(
          right: 17.0,
          top: 20.0,
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
                        ? Colors.black.withOpacity(0.019)
                        : Colors.black.withOpacity(0.025),
                  ],
                  stops: [0.2, 0.2],
                  begin: FractionalOffset(0.7, 0.3),
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
