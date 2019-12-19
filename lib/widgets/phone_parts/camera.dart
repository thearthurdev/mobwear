import 'package:flutter/material.dart';

class Camera extends StatelessWidget {
  final double diameter, trimWidth, lenseDiameter;
  final Color trimColor, backPanelColor;
  final bool hasElevation;

  const Camera({
    this.diameter = 35.0,
    this.trimWidth = 5.0,
    this.lenseDiameter = 10.0,
    this.trimColor,
    this.hasElevation = false,
    this.backPanelColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      child: FittedBox(
        child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: trimColor ?? Colors.grey[400],
            boxShadow: hasElevation
                ? [
                    BoxShadow(
                      color: backPanelColor.computeLuminance() > 0.335
                          ? Colors.black26
                          : Colors.black38,
                      spreadRadius: 1.0,
                      blurRadius: 3.0,
                    )
                  ]
                : null,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: diameter - trimWidth,
                height: diameter - trimWidth,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
              Container(
                width: lenseDiameter,
                height: lenseDiameter,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[700],
                ),
              ),
              Container(
                width: 3.0,
                height: 3.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
