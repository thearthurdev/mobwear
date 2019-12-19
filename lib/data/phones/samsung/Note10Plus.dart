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

class Note10Plus extends StatelessWidget {
  static const String phoneBrand = 'Samsung';
  static const String phoneModel = 'Galaxy';
  static const String phoneName = 'Galaxy Note 10 Plus';

  final Screen front = Screen(
    screenWidth: 240.0,
    screenHeight: 510.0,
    bezelHorizontal: 5.0,
    bezelVertical: 15.0,
    screenAlignment: Alignment(0.0, -0.5),
    innerCornerRadius: 6.0,
    cornerRadius: 6.0,
    screenItems: <Widget>[
      Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Camera(
            diameter: 15.0,
            lenseDiameter: 5.0,
            trimWidth: 0.0,
          ),
        ),
      ),
    ],
    phoneBrand: phoneBrand,
    phoneModel: phoneModel,
    phoneName: phoneName,
  );

  get getPhoneName => phoneName;
  get getPhoneFront => front;

  @override
  Widget build(BuildContext context) {
    var colors = Provider.of<PhonesData>(context).samsungs[1].colors;

    Color backPanelColor = colors['Back Panel'];
    Color cameraBumpColor = colors['Camera Bump'];
    Color logoColor = colors['Samsung Logo'];
    Color bezelColor = colors['Bezels'];

    Camera camera = Camera(
      diameter: 20.0,
      trimWidth: 3.0,
      lenseDiameter: 8.0,
      trimColor: Colors.grey[900],
    );

    CameraBump cameraBump = CameraBump(
      width: 35.0,
      height: 105.0,
      cameraBumpColor: cameraBumpColor,
      backPanelColor: backPanelColor,
      cameraBumpPartsPadding: 2.0,
      borderWidth: 2.0,
      borderColor: Colors.grey[500],
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

    return FittedBox(
      child: Stack(
        children: <Widget>[
          BackPanel(
            height: 510,
            cornerRadius: 6.0,
            backPanelColor: Colors.transparent,
            bezelColor: Colors.transparent,
            child: Container(),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 240.0,
              height: 510.0,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(6.0),
                color: backPanelColor,
                border: Border(
                  top: BorderSide(
                    color: bezelColor,
                    width: 3.0,
                  ),
                  bottom: BorderSide(
                    color: bezelColor,
                    width: 3.0,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(5, 5),
                    spreadRadius: 2.0,
                    blurRadius: 10.0,
                  )
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(6.0),
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
                    child: Align(
                      alignment: Alignment(-0.185, -0.3),
                      child: Icon(
                        BrandIcons.samsung2,
                        color: logoColor,
                        size: 40.0,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 18.0,
                    left: 20.0,
                    child: cameraBump,
                  ),
                  Positioned(
                    left: 70.0,
                    top: 33.0,
                    child: Column(
                      children: <Widget>[
                        Flash(diameter: 10.0),
                        SizedBox(height: 8.0),
                        Microphone(diameter: 10.0),
                        SizedBox(height: 8.0),
                        Microphone(diameter: 10.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
