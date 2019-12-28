import 'package:flutter/material.dart';
import 'package:mobware/custom_icons/brand_icons.dart';
import 'package:mobware/providers/phones_data.dart';
import 'package:mobware/widgets/phone_parts/back_panel.dart';
import 'package:mobware/widgets/phone_parts/camera.dart';
import 'package:mobware/widgets/phone_parts/fingerprint_sensor.dart';
import 'package:mobware/widgets/phone_parts/flash.dart';
import 'package:mobware/widgets/phone_parts/microphone.dart';
import 'package:mobware/widgets/phone_parts/screen.dart';
import 'package:provider/provider.dart';

class Pixel3XL extends StatelessWidget {
  final int phoneIndex = 3;
  final int phoneBrandIndex = 0;
  static const String phoneBrand = 'Google';
  static const String phoneModel = 'Pixel';
  static const String phoneName = 'Pixel 3 XL';

  final Screen front = Screen(
    hasNotch: true,
    bezelVertical: 40.0,
    screenAlignment: Alignment(0.0, -0.6),
    notchAlignment: Alignment(0.0, -1.0),
    notchHeight: 35.0,
    notchWidth: 100.0,
    cornerRadius: 23.0,
    phoneBrand: phoneBrand,
    phoneModel: phoneModel,
    phoneName: phoneName,
  );

  get getPhoneName => phoneName;
  get getPhoneFront => front;
  get getPhoneBrand => phoneBrand;

  @override
  Widget build(BuildContext context) {
    var colors = Provider.of<PhonesData>(context).pixels[3].colors;

    Color glossPanelColor = colors['Gloss Panel'];
    Color mattePanelColor = colors['Matte Panel'];
    Color fingerprintSensorColor = colors['Fingerprint Sensor'];
    Color logoColor = colors['Google Logo'];

    return FittedBox(
      child: BackPanel(
        backPanelColor: glossPanelColor,
        bezelColor: glossPanelColor,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 240.0,
                height: 380.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23.0),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.05),
                    width: 1.0,
                  ),
                  color: mattePanelColor,
                ),
                child: Container(
                  width: 240.0,
                  height: 380.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23.0),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.05),
                      width: 1.0,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        mattePanelColor.computeLuminance() > 0.335
                            ? Colors.black12
                            : Colors.black26
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      FingerprintSensor(
                        sensorColor: fingerprintSensorColor,
                        diameter: 37.0,
                        trimColor: mattePanelColor,
                      ),
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
              ),
            ),
            Positioned(
              top: 30.0,
              left: 20.0,
              child: Row(
                children: <Widget>[
                  Camera(),
                  SizedBox(width: 8.0),
                  Microphone(),
                  SizedBox(width: 8.0),
                  Flash(
                    diameter: 15.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
