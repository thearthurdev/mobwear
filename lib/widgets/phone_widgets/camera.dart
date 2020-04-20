import 'package:flutter/material.dart';

class Camera extends StatelessWidget {
  final double width, height, diameter, trimWidth, elevation;
  final double lenseWidth, lenseHeight, lenseDiameter, lenseCornerRadius;
  final double cornerRadius, elevationSpreadRadius, elevationBlurRadius;
  final Color trimColor, lenseColor, backPanelColor;
  final bool hasElevation;

  const Camera({
    this.width,
    this.height,
    this.cornerRadius = 10.0,
    this.diameter = 35.0,
    this.trimWidth = 5.0,
    this.lenseDiameter = 10.0,
    this.lenseCornerRadius = 4.0,
    this.lenseWidth,
    this.lenseHeight,
    this.elevation,
    this.elevationSpreadRadius,
    this.elevationBlurRadius,
    this.trimColor,
    this.lenseColor,
    this.backPanelColor = Colors.black,
    this.hasElevation = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? diameter,
      height: height ?? diameter,
      child: FittedBox(
        child: Container(
          width: width ?? diameter,
          height: height ?? diameter,
          decoration: BoxDecoration(
            shape: width == null || height == null
                ? BoxShape.circle
                : BoxShape.rectangle,
            borderRadius: width == null || height == null
                ? null
                : BorderRadius.circular(cornerRadius),
            color: trimColor ?? Colors.grey[600],
            boxShadow: hasElevation
                ? [
                    BoxShadow(
                      color: backPanelColor.computeLuminance() > 0.335
                          ? Colors.black.withOpacity(0.1)
                          : Colors.black.withOpacity(0.2),
                      spreadRadius: elevationSpreadRadius ?? 1.0,
                      blurRadius: elevationBlurRadius ?? 3.0,
                      offset: Offset(2.0, 2.0),
                    ),
                    BoxShadow(
                      color: backPanelColor.computeLuminance() > 0.335
                          ? Colors.black.withOpacity(0.1)
                          : Colors.black.withOpacity(0.2),
                      spreadRadius: elevationSpreadRadius ?? 1.0,
                      blurRadius: elevationBlurRadius ?? 3.0,
                      offset: Offset(-0.2, -0.2),
                    )
                  ]
                : null,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: (width ?? diameter) - trimWidth,
                height: (height ?? diameter) - trimWidth,
                decoration: BoxDecoration(
                  shape: width == null || height == null
                      ? BoxShape.circle
                      : BoxShape.rectangle,
                  borderRadius: width == null || height == null
                      ? null
                      : BorderRadius.circular(
                          cornerRadius - (cornerRadius > 2.0 ? 2.0 : 0.0)),
                  color: Colors.black,
                ),
              ),
              Container(
                width: lenseWidth ?? lenseDiameter,
                height: lenseHeight ?? lenseDiameter,
                decoration: BoxDecoration(
                  shape: lenseWidth == null || lenseHeight == null
                      ? BoxShape.circle
                      : BoxShape.rectangle,
                  borderRadius: width == null || lenseHeight == null
                      ? null
                      : BorderRadius.circular(lenseCornerRadius -
                          (lenseCornerRadius > 2.0 ? 2.0 : 0.0)),
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
