import 'package:flutter/material.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

class FingerprintSensor extends StatelessWidget {
  final Color sensorColor, trimColor;
  final double width, height, diameter, trimWidth, cornerRadius;
  final int phoneID;
  final String boxColorKey;

  const FingerprintSensor({
    @required this.phoneID,
    @required this.sensorColor,
    this.boxColorKey,
    this.trimColor,
    this.width,
    this.height,
    this.diameter = 43.0,
    this.trimWidth = 2.0,
    this.cornerRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    Box<dynamic> phonesBox =
        Provider.of<CustomizationProvider>(context).phonesBox;

    var boxBackPanelColor =
        phonesBox.get(phoneID).colors[boxColorKey ?? 'Back Panel'];

    return Container(
      width: width ?? diameter,
      height: height ?? diameter,
      decoration: BoxDecoration(
        shape: width == null || height == null || width == height
            ? BoxShape.circle
            : BoxShape.rectangle,
        borderRadius: width == null || height == null || width == height
            ? null
            : BorderRadius.circular(cornerRadius),
        color: sensorColor,
        border: Border.all(
          color: trimColor == null
              ? boxBackPanelColor.computeLuminance() > 0.335
                  ? Colors.black.withOpacity(0.08)
                  : Colors.black.withOpacity(0.12)
              : trimColor,
          width: trimWidth,
        ),
      ),
    );
  }
}
