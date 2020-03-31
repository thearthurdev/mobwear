import 'package:flutter/material.dart';

class Camera extends StatelessWidget {
  final double diameter, trimWidth, lenseDiameter;
  final Color trimColor, lenseColor, backPanelColor;
  final bool hasElevation;

  const Camera({
    this.diameter = 35.0,
    this.trimWidth = 5.0,
    this.lenseDiameter = 10.0,
    this.hasElevation = false,
    this.trimColor,
    this.lenseColor,
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
            color: trimColor ?? Colors.grey[600],
            boxShadow: hasElevation
                ? [
                    BoxShadow(
                      color: backPanelColor.computeLuminance() > 0.335
                          ? Colors.black.withOpacity(0.1)
                          : Colors.black.withOpacity(0.2),
                      spreadRadius: 1.0,
                      blurRadius: 3.0,
                      offset: Offset(2.0, 2.0),
                    ),
                    BoxShadow(
                      color: backPanelColor.computeLuminance() > 0.335
                          ? Colors.black.withOpacity(0.1)
                          : Colors.black.withOpacity(0.2),
                      spreadRadius: 1.0,
                      blurRadius: 3.0,
                      offset: Offset(-0.2, -0.2),
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
                  color: lenseColor ?? Colors.grey[900],
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
