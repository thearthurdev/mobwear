import 'package:flutter/material.dart';
import 'package:mobware/custom_icons/brand_icons.dart';
import 'package:mobware/providers/phones_data.dart';
import 'package:mobware/widgets/phone_widgets/back_panel.dart';
import 'package:mobware/widgets/phone_widgets/camera.dart';
import 'package:mobware/widgets/phone_widgets/fingerprint_sensor.dart';
import 'package:mobware/widgets/phone_widgets/flash.dart';
import 'package:mobware/widgets/phone_widgets/microphone.dart';
import 'package:mobware/widgets/phone_widgets/screen.dart';
import 'package:provider/provider.dart';

class PixelXL extends StatelessWidget {
  final int phoneIndex = 0;
  final int phoneBrandIndex = 0;
  static const String phoneBrand = 'Google';
  static const String phoneModel = 'Pixel';
  static const String phoneName = 'Pixel XL';

  final Screen front = Screen(
    phoneName: phoneName,
    phoneModel: phoneModel,
    phoneBrand: phoneBrand,
    bezelVertical: 120.0,
    innerCornerRadius: 0.0,
    screenAlignment: Alignment.center,
    notchAlignment: Alignment(0.0, -1.0),
    notchHeight: 35.0,
    notchWidth: 100.0,
    cornerRadius: 33.0,
    screenBezelColor: Colors.white,
  );

  get getPhoneFront => front;
  get getPhoneName => phoneName;
  get getPhoneBrand => phoneBrand;

  @override
  Widget build(BuildContext context) {
    var colors = Provider.of<PhonesData>(context).pixels[0].colors;

    Color glossPanelColor = colors['Glossy Panel'];
    Color mattePanelColor = colors['Matte Panel'];
    Color fingerprintSensorColor = colors['Fingerprint Sensor'];
    Color logoColor = colors['Google Logo'];
    Color antennaBandsColor = colors['Antenna Bands'];

    return FittedBox(
      child: BackPanel(
        height: 470.0,
        cornerRadius: 30.0,
        backPanelColor: mattePanelColor,
        bezelColor: mattePanelColor,
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: 40.0),
                Container(
                  color: antennaBandsColor,
                  height: 6.0,
                  width: double.infinity,
                ),
                Expanded(
                  child: Container(),
                ),
                Icon(
                  BrandIcons.google,
                  color: logoColor,
                  size: 30.0,
                ),
                SizedBox(height: 50.0),
                Container(
                  color: antennaBandsColor,
                  height: 6.0,
                  width: double.infinity,
                ),
                SizedBox(height: 20.0),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.all(4.0),
                width: 240.0,
                height: 160.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  color: glossPanelColor,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: FingerprintSensor(
                      sensorColor: fingerprintSensorColor,
                      trimColor: Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20.0,
              left: 20.0,
              child: Row(
                children: <Widget>[
                  Flash(diameter: 15.0),
                  SizedBox(width: 10.0),
                  Camera(
                    diameter: 17.0,
                    trimWidth: 3.0,
                    lenseDiameter: 7.0,
                  ),
                  SizedBox(width: 10.0),
                  Microphone(diameter: 6),
                  SizedBox(width: 3.0),
                  Microphone(diameter: 6),
                  SizedBox(width: 3.0),
                  Microphone(diameter: 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
