import 'package:flutter/material.dart';
import 'package:mobware/custom_icons/brand_icons.dart';
import 'package:mobware/providers/phones_data.dart';
import 'package:mobware/widgets/phone_parts/back_panel.dart';
import 'package:mobware/widgets/phone_parts/camera.dart';
import 'package:mobware/widgets/phone_parts/camera_bump.dart';
import 'package:mobware/widgets/phone_parts/flash.dart';
import 'package:mobware/widgets/phone_parts/iPhone_home_button.dart';
import 'package:mobware/widgets/phone_parts/iPhone_text_marks.dart';
import 'package:mobware/widgets/phone_parts/microphone.dart';
import 'package:mobware/widgets/phone_parts/screen.dart';
import 'package:provider/provider.dart';

class IPhone8Plus extends StatelessWidget {
  final int phoneIndex = 0;
  final int phoneBrandIndex = 1;
  static const String phoneBrand = 'Apple';
  static const String phoneModel = 'iPhone';
  static const String phoneName = 'iPhone 8 Plus';

  final Screen front = Screen(
    bezelHorizontal: 15.0,
    bezelVertical: 120.0,
    innerCornerRadius: 0.0,
    screenBezelColor: Colors.white,
    screenItems: <Widget>[
      Align(
        alignment: Alignment(0.0, 0.96),
        child: IPhoneHomeButton(
          buttonColor: Colors.white,
        ),
      ),
    ],
    phoneBrand: phoneBrand,
    phoneModel: phoneModel,
    phoneName: phoneName,
  );

  get getPhoneName => phoneName;
  get getPhoneFront => front;
  get getPhoneBrand => phoneBrand;

  @override
  Widget build(BuildContext context) {
    var colors = Provider.of<PhonesData>(context).iPhones[0].colors;

    Color cameraBumpColor = colors['Camera Bump'];
    Color backPanelColor = colors['Back Panel'];
    Color logoColor = colors['Apple Logo'];
    Color textMarksColor = colors['iPhone Text'];

    Camera camera = Camera(
      diameter: 20.0,
      lenseDiameter: 8.0,
      trimWidth: 3.0,
      trimColor: Colors.grey[900],
    );

    CameraBump cameraBump = CameraBump(
      height: 30.0,
      width: 60.0,
      cameraBumpPartsPadding: 0.0,
      borderWidth: 3.0,
      backPanelColor: backPanelColor,
      cameraBumpColor: cameraBumpColor,
      borderColor: Colors.grey[400],
      cameraBumpParts: <Widget>[
        Positioned(
          left: 3.0,
          top: 5.0,
          child: camera,
        ),
        Positioned(
          right: 3.0,
          top: 5.0,
          child: camera,
        ),
      ],
    );

    return FittedBox(
      child: BackPanel(
        width: 250.0,
        height: 500.0,
        cornerRadius: 36.0,
        backPanelColor: backPanelColor,
        bezelColor: backPanelColor,
        bezelWidth: 3.0,
        child: Stack(
          children: <Widget>[
            Container(
              width: 250.0,
              height: 500.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36.0),
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
              top: 15.0,
              left: 15.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  cameraBump,
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
              alignment: Alignment(0.0, 0.6),
              child: IPhoneTextMarks(
                color: textMarksColor,
                ceMarkings: false,
                designedByText: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
