import 'package:flutter/material.dart';

class FingerprintSensor extends StatelessWidget {
  final Color sensorColor, trimColor;
  final double diameter, trimWidth;

  const FingerprintSensor({
    @required this.sensorColor,
    this.trimColor,
    this.diameter = 43.0,
    this.trimWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: sensorColor,
        border: Border.all(
          color: trimColor ?? Colors.grey[400],
          width: trimWidth,
        ),
      ),
    );
  }
}
