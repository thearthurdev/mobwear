import 'package:flutter/material.dart';
import 'package:mobware/custom_icons/brand_icons.dart';
import 'package:mobware/providers/phones_data.dart';
import 'package:mobware/widgets/phone_widgets/back_panel.dart';
import 'package:mobware/widgets/phone_widgets/camera.dart';
import 'package:mobware/widgets/phone_widgets/flash.dart';
import 'package:mobware/widgets/phone_widgets/iPhone_text_marks.dart';
import 'package:mobware/widgets/phone_widgets/microphone.dart';
import 'package:mobware/widgets/phone_widgets/screen.dart';
import 'package:provider/provider.dart';

class IPhoneXR extends StatelessWidget {
  final int phoneIndex = 1;
  final int phoneBrandIndex = 1;
  static const String phoneBrand = 'Apple';
  static const String phoneModel = 'iPhone';
  static const String phoneName = 'iPhone XR';

  final Screen front = Screen(
    phoneName: phoneName,
    phoneModel: phoneModel,
    phoneBrand: phoneBrand,
    hasNotch: true,
    bezelHorizontal: 20.0,
    bezelVertical: 20.0,
  );

  get getPhoneName => phoneName;
  get getPhoneFront => front;
  get getPhoneBrand => phoneBrand;

  @override
  Widget build(BuildContext context) {
    var colors = Provider.of<PhonesData>(context).iPhones[1].colors;

    Color backPanelColor = colors['Back Panel'];
    Color logoColor = colors['Apple Logo'];
    Color textMarksColor = colors['iPhone Text'];

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
              top: 15.0,
              left: 15.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Camera(
                    diameter: 40.0,
                    lenseDiameter: 10.0,
                    trimWidth: 4.0,
                    trimColor: Colors.grey[500],
                    hasElevation: true,
                    backPanelColor: backPanelColor,
                  ),
                  SizedBox(height: 8.0),
                  Microphone(),
                  SizedBox(height: 8.0),
                  Flash(diameter: 15.0),
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
